"""Build-time lexical checks for this project's restricted GenExpr subset.

Not the native Gen compiler. Rejects unknown/out-of-scope variables BEFORE
the arithmetic adapter can hoist its C++ locals and hide a source defect.
Unsupported syntax fails explicitly rather than being silently accepted.
"""
import re

TOKEN = re.compile(r'\s+|//[^\n]*|/\*[\s\S]*?\*/|'
                   r'(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?|'
                   r'[A-Za-z_]\w*|==|!=|<=|>=|&&|\|\||[{}();,+*/%?:=<>!\-]')
FUNCTIONS = {'clamp', 'min', 'max', 'floor', 'exp', 'sqrt', 'abs', 'peek', 'poke'}
READ_ONLY = {'samplerate', 'pi', 'PI'}


class ScopeError(ValueError):
    pass


def validate_scope(source, *, inputs, outputs):
    tokens=[]; last=0
    for match in TOKEN.finditer(source):
        if match.start()!=last:
            raise ScopeError('Unsupported syntax at offset '+str(last))
        value=match.group(); last=match.end()
        if value.isspace() or value.startswith(('//','/*')):continue
        tokens.append((value,source.count('\n',0,match.start())+1))
    if last!=len(source):raise ScopeError('Unsupported trailing syntax')
    position=0
    scopes=[READ_ONLY | {'in'+str(i+1) for i in range(inputs)} |
            {'out'+str(i+1) for i in range(outputs)}]

    def current():
        return tokens[position][0] if position<len(tokens) else None

    def take(expected=None):
        nonlocal position
        if current() is None:raise ScopeError('Unexpected end of source')
        token=tokens[position];position+=1
        if expected is not None and token[0]!=expected:
            raise ScopeError(f'Expected {expected}, received {token[0]} at line {token[1]}')
        return token

    def known(name):return any(name in scope for scope in reversed(scopes))

    def expression(parts):
        for i,(word,line) in enumerate(parts):
            if not re.fullmatch(r'[A-Za-z_]\w*',word):continue
            call=i+1<len(parts) and parts[i+1][0]=='('
            if call:
                if word not in FUNCTIONS:raise ScopeError(f'Unknown function {word} at line {line}')
            elif not known(word):
                raise ScopeError(f'Variable {word} is not defined in this scope at line {line}')

    def until(delimiter, *, assignment=False):
        parts=[];depth=0
        while current() is not None:
            if current()==delimiter and depth==0:break
            token=take()
            if token[0]=='(':depth+=1
            if token[0]==')':depth-=1
            if depth<0:raise ScopeError('Unbalanced expression')
            parts.append(token)
        take(delimiter)
        if assignment and len(parts)>1 and parts[1][0]=='=':
            name,line=parts[0]
            if not re.fullmatch(r'[A-Za-z_]\w*',name):raise ScopeError('Invalid assignment')
            if name in READ_ONLY:raise ScopeError(f'{name} is built-in and cannot be assigned at line {line}')
            expression(parts[2:])
            if not known(name):scopes[-1].add(name)
        else:expression(parts)

    def block():
        take('{');scopes.append(set())
        while current()!='}':statement()
        take('}');scopes.pop()

    def conditional():
        take('if');take('(');until(')');block()
        if current()=='else':
            take('else')
            if current()=='if':conditional()
            else:block()

    def statement():
        if current() in ('Param','History','Data'):
            take();name,line=take();take('(');until(')');take(';')
            if known(name):raise ScopeError(f'Duplicate declaration {name} at line {line}')
            scopes[-1].add(name)
        elif current()=='if':conditional()
        elif current()=='for':
            take('for');take('(');scopes.append(set())
            until(';',assignment=True);until(';');until(')',assignment=True)
            block();scopes.pop()
        elif current()=='while':
            take('while');take('(');until(')');block()
        elif current() is None:
            raise ScopeError('Unexpected end of block')
        else:until(';',assignment=True)

    while current() is not None:statement()
