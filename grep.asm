
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 c6 00 00 00       	jmp    d8 <grep+0xd8>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 e0 12 00 00       	add    $0x12e0,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 e0 12 00 00 	movl   $0x12e0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 51                	jmp    7d <grep+0x7d>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  35:	89 44 24 04          	mov    %eax,0x4(%esp)
  39:	8b 45 08             	mov    0x8(%ebp),%eax
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 bc 01 00 00       	call   200 <match>
  44:	85 c0                	test   %eax,%eax
  46:	74 2c                	je     74 <grep+0x74>
        *q = '\n';
  48:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4b:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  51:	83 c0 01             	add    $0x1,%eax
  54:	89 c2                	mov    %eax,%edx
  56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  59:	29 c2                	sub    %eax,%edx
  5b:	89 d0                	mov    %edx,%eax
  5d:	89 44 24 08          	mov    %eax,0x8(%esp)
  61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  64:	89 44 24 04          	mov    %eax,0x4(%esp)
  68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6f:	e8 74 05 00 00       	call   5e8 <write>
      }
      p = q+1;
  74:	8b 45 e8             	mov    -0x18(%ebp),%eax
  77:	83 c0 01             	add    $0x1,%eax
  7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  7d:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  84:	00 
  85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  88:	89 04 24             	mov    %eax,(%esp)
  8b:	e8 af 03 00 00       	call   43f <strchr>
  90:	89 45 e8             	mov    %eax,-0x18(%ebp)
  93:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  97:	75 93                	jne    2c <grep+0x2c>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  99:	81 7d f0 e0 12 00 00 	cmpl   $0x12e0,-0x10(%ebp)
  a0:	75 07                	jne    a9 <grep+0xa9>
      m = 0;
  a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  ad:	7e 29                	jle    d8 <grep+0xd8>
      m -= p - buf;
  af:	ba e0 12 00 00       	mov    $0x12e0,%edx
  b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  b7:	29 c2                	sub    %eax,%edx
  b9:	89 d0                	mov    %edx,%eax
  bb:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c1:	89 44 24 08          	mov    %eax,0x8(%esp)
  c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  cc:	c7 04 24 e0 12 00 00 	movl   $0x12e0,(%esp)
  d3:	e8 ab 04 00 00       	call   583 <memmove>
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  db:	ba ff 03 00 00       	mov    $0x3ff,%edx
  e0:	29 c2                	sub    %eax,%edx
  e2:	89 d0                	mov    %edx,%eax
  e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  e7:	81 c2 e0 12 00 00    	add    $0x12e0,%edx
  ed:	89 44 24 08          	mov    %eax,0x8(%esp)
  f1:	89 54 24 04          	mov    %edx,0x4(%esp)
  f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  f8:	89 04 24             	mov    %eax,(%esp)
  fb:	e8 e0 04 00 00       	call   5e0 <read>
 100:	89 45 ec             	mov    %eax,-0x14(%ebp)
 103:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 107:	0f 8f 05 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 10d:	c9                   	leave  
 10e:	c3                   	ret    

0000010f <main>:

int
main(int argc, char *argv[])
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	83 e4 f0             	and    $0xfffffff0,%esp
 115:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 118:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 11c:	7f 19                	jg     137 <main+0x28>
    printf(2, "usage: grep pattern [file ...]\n");
 11e:	c7 44 24 04 e4 0d 00 	movl   $0xde4,0x4(%esp)
 125:	00 
 126:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 12d:	e8 3e 06 00 00       	call   770 <printf>
    exit();
 132:	e8 91 04 00 00       	call   5c8 <exit>
  }
  pattern = argv[1];
 137:	8b 45 0c             	mov    0xc(%ebp),%eax
 13a:	8b 40 04             	mov    0x4(%eax),%eax
 13d:	89 44 24 18          	mov    %eax,0x18(%esp)
  
  if(argc <= 2){
 141:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 145:	7f 19                	jg     160 <main+0x51>
    grep(pattern, 0);
 147:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 14e:	00 
 14f:	8b 44 24 18          	mov    0x18(%esp),%eax
 153:	89 04 24             	mov    %eax,(%esp)
 156:	e8 a5 fe ff ff       	call   0 <grep>
    exit();
 15b:	e8 68 04 00 00       	call   5c8 <exit>
  }

  for(i = 2; i < argc; i++){
 160:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
 167:	00 
 168:	e9 81 00 00 00       	jmp    1ee <main+0xdf>
    if((fd = open(argv[i], 0)) < 0){
 16d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 171:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 178:	8b 45 0c             	mov    0xc(%ebp),%eax
 17b:	01 d0                	add    %edx,%eax
 17d:	8b 00                	mov    (%eax),%eax
 17f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 186:	00 
 187:	89 04 24             	mov    %eax,(%esp)
 18a:	e8 79 04 00 00       	call   608 <open>
 18f:	89 44 24 14          	mov    %eax,0x14(%esp)
 193:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
 198:	79 2f                	jns    1c9 <main+0xba>
      printf(1, "grep: cannot open %s\n", argv[i]);
 19a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 19e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	01 d0                	add    %edx,%eax
 1aa:	8b 00                	mov    (%eax),%eax
 1ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b0:	c7 44 24 04 04 0e 00 	movl   $0xe04,0x4(%esp)
 1b7:	00 
 1b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1bf:	e8 ac 05 00 00       	call   770 <printf>
      exit();
 1c4:	e8 ff 03 00 00       	call   5c8 <exit>
    }
    grep(pattern, fd);
 1c9:	8b 44 24 14          	mov    0x14(%esp),%eax
 1cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d1:	8b 44 24 18          	mov    0x18(%esp),%eax
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 23 fe ff ff       	call   0 <grep>
    close(fd);
 1dd:	8b 44 24 14          	mov    0x14(%esp),%eax
 1e1:	89 04 24             	mov    %eax,(%esp)
 1e4:	e8 07 04 00 00       	call   5f0 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1e9:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1ee:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1f2:	3b 45 08             	cmp    0x8(%ebp),%eax
 1f5:	0f 8c 72 ff ff ff    	jl     16d <main+0x5e>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1fb:	e8 c8 03 00 00       	call   5c8 <exit>

00000200 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	0f b6 00             	movzbl (%eax),%eax
 20c:	3c 5e                	cmp    $0x5e,%al
 20e:	75 17                	jne    227 <match+0x27>
    return matchhere(re+1, text);
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	8d 50 01             	lea    0x1(%eax),%edx
 216:	8b 45 0c             	mov    0xc(%ebp),%eax
 219:	89 44 24 04          	mov    %eax,0x4(%esp)
 21d:	89 14 24             	mov    %edx,(%esp)
 220:	e8 36 00 00 00       	call   25b <matchhere>
 225:	eb 32                	jmp    259 <match+0x59>
  do{  // must look at empty string
    if(matchhere(re, text))
 227:	8b 45 0c             	mov    0xc(%ebp),%eax
 22a:	89 44 24 04          	mov    %eax,0x4(%esp)
 22e:	8b 45 08             	mov    0x8(%ebp),%eax
 231:	89 04 24             	mov    %eax,(%esp)
 234:	e8 22 00 00 00       	call   25b <matchhere>
 239:	85 c0                	test   %eax,%eax
 23b:	74 07                	je     244 <match+0x44>
      return 1;
 23d:	b8 01 00 00 00       	mov    $0x1,%eax
 242:	eb 15                	jmp    259 <match+0x59>
  }while(*text++ != '\0');
 244:	8b 45 0c             	mov    0xc(%ebp),%eax
 247:	8d 50 01             	lea    0x1(%eax),%edx
 24a:	89 55 0c             	mov    %edx,0xc(%ebp)
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	75 d3                	jne    227 <match+0x27>
  return 0;
 254:	b8 00 00 00 00       	mov    $0x0,%eax
}
 259:	c9                   	leave  
 25a:	c3                   	ret    

0000025b <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 25b:	55                   	push   %ebp
 25c:	89 e5                	mov    %esp,%ebp
 25e:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	84 c0                	test   %al,%al
 269:	75 0a                	jne    275 <matchhere+0x1a>
    return 1;
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	e9 9b 00 00 00       	jmp    310 <matchhere+0xb5>
  if(re[1] == '*')
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	83 c0 01             	add    $0x1,%eax
 27b:	0f b6 00             	movzbl (%eax),%eax
 27e:	3c 2a                	cmp    $0x2a,%al
 280:	75 24                	jne    2a6 <matchhere+0x4b>
    return matchstar(re[0], re+2, text);
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	8d 48 02             	lea    0x2(%eax),%ecx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	0f be c0             	movsbl %al,%eax
 291:	8b 55 0c             	mov    0xc(%ebp),%edx
 294:	89 54 24 08          	mov    %edx,0x8(%esp)
 298:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 29c:	89 04 24             	mov    %eax,(%esp)
 29f:	e8 6e 00 00 00       	call   312 <matchstar>
 2a4:	eb 6a                	jmp    310 <matchhere+0xb5>
  if(re[0] == '$' && re[1] == '\0')
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	0f b6 00             	movzbl (%eax),%eax
 2ac:	3c 24                	cmp    $0x24,%al
 2ae:	75 1d                	jne    2cd <matchhere+0x72>
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	83 c0 01             	add    $0x1,%eax
 2b6:	0f b6 00             	movzbl (%eax),%eax
 2b9:	84 c0                	test   %al,%al
 2bb:	75 10                	jne    2cd <matchhere+0x72>
    return *text == '\0';
 2bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c0:	0f b6 00             	movzbl (%eax),%eax
 2c3:	84 c0                	test   %al,%al
 2c5:	0f 94 c0             	sete   %al
 2c8:	0f b6 c0             	movzbl %al,%eax
 2cb:	eb 43                	jmp    310 <matchhere+0xb5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d0:	0f b6 00             	movzbl (%eax),%eax
 2d3:	84 c0                	test   %al,%al
 2d5:	74 34                	je     30b <matchhere+0xb0>
 2d7:	8b 45 08             	mov    0x8(%ebp),%eax
 2da:	0f b6 00             	movzbl (%eax),%eax
 2dd:	3c 2e                	cmp    $0x2e,%al
 2df:	74 10                	je     2f1 <matchhere+0x96>
 2e1:	8b 45 08             	mov    0x8(%ebp),%eax
 2e4:	0f b6 10             	movzbl (%eax),%edx
 2e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ea:	0f b6 00             	movzbl (%eax),%eax
 2ed:	38 c2                	cmp    %al,%dl
 2ef:	75 1a                	jne    30b <matchhere+0xb0>
    return matchhere(re+1, text+1);
 2f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f4:	8d 50 01             	lea    0x1(%eax),%edx
 2f7:	8b 45 08             	mov    0x8(%ebp),%eax
 2fa:	83 c0 01             	add    $0x1,%eax
 2fd:	89 54 24 04          	mov    %edx,0x4(%esp)
 301:	89 04 24             	mov    %eax,(%esp)
 304:	e8 52 ff ff ff       	call   25b <matchhere>
 309:	eb 05                	jmp    310 <matchhere+0xb5>
  return 0;
 30b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 310:	c9                   	leave  
 311:	c3                   	ret    

00000312 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 312:	55                   	push   %ebp
 313:	89 e5                	mov    %esp,%ebp
 315:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 318:	8b 45 10             	mov    0x10(%ebp),%eax
 31b:	89 44 24 04          	mov    %eax,0x4(%esp)
 31f:	8b 45 0c             	mov    0xc(%ebp),%eax
 322:	89 04 24             	mov    %eax,(%esp)
 325:	e8 31 ff ff ff       	call   25b <matchhere>
 32a:	85 c0                	test   %eax,%eax
 32c:	74 07                	je     335 <matchstar+0x23>
      return 1;
 32e:	b8 01 00 00 00       	mov    $0x1,%eax
 333:	eb 29                	jmp    35e <matchstar+0x4c>
  }while(*text!='\0' && (*text++==c || c=='.'));
 335:	8b 45 10             	mov    0x10(%ebp),%eax
 338:	0f b6 00             	movzbl (%eax),%eax
 33b:	84 c0                	test   %al,%al
 33d:	74 1a                	je     359 <matchstar+0x47>
 33f:	8b 45 10             	mov    0x10(%ebp),%eax
 342:	8d 50 01             	lea    0x1(%eax),%edx
 345:	89 55 10             	mov    %edx,0x10(%ebp)
 348:	0f b6 00             	movzbl (%eax),%eax
 34b:	0f be c0             	movsbl %al,%eax
 34e:	3b 45 08             	cmp    0x8(%ebp),%eax
 351:	74 c5                	je     318 <matchstar+0x6>
 353:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 357:	74 bf                	je     318 <matchstar+0x6>
  return 0;
 359:	b8 00 00 00 00       	mov    $0x0,%eax
}
 35e:	c9                   	leave  
 35f:	c3                   	ret    

00000360 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 365:	8b 4d 08             	mov    0x8(%ebp),%ecx
 368:	8b 55 10             	mov    0x10(%ebp),%edx
 36b:	8b 45 0c             	mov    0xc(%ebp),%eax
 36e:	89 cb                	mov    %ecx,%ebx
 370:	89 df                	mov    %ebx,%edi
 372:	89 d1                	mov    %edx,%ecx
 374:	fc                   	cld    
 375:	f3 aa                	rep stos %al,%es:(%edi)
 377:	89 ca                	mov    %ecx,%edx
 379:	89 fb                	mov    %edi,%ebx
 37b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 37e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 381:	5b                   	pop    %ebx
 382:	5f                   	pop    %edi
 383:	5d                   	pop    %ebp
 384:	c3                   	ret    

00000385 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 385:	55                   	push   %ebp
 386:	89 e5                	mov    %esp,%ebp
 388:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 38b:	8b 45 08             	mov    0x8(%ebp),%eax
 38e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 391:	90                   	nop
 392:	8b 45 08             	mov    0x8(%ebp),%eax
 395:	8d 50 01             	lea    0x1(%eax),%edx
 398:	89 55 08             	mov    %edx,0x8(%ebp)
 39b:	8b 55 0c             	mov    0xc(%ebp),%edx
 39e:	8d 4a 01             	lea    0x1(%edx),%ecx
 3a1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 3a4:	0f b6 12             	movzbl (%edx),%edx
 3a7:	88 10                	mov    %dl,(%eax)
 3a9:	0f b6 00             	movzbl (%eax),%eax
 3ac:	84 c0                	test   %al,%al
 3ae:	75 e2                	jne    392 <strcpy+0xd>
    ;
  return os;
 3b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3b8:	eb 08                	jmp    3c2 <strcmp+0xd>
    p++, q++;
 3ba:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3be:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3c2:	8b 45 08             	mov    0x8(%ebp),%eax
 3c5:	0f b6 00             	movzbl (%eax),%eax
 3c8:	84 c0                	test   %al,%al
 3ca:	74 10                	je     3dc <strcmp+0x27>
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	0f b6 10             	movzbl (%eax),%edx
 3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d5:	0f b6 00             	movzbl (%eax),%eax
 3d8:	38 c2                	cmp    %al,%dl
 3da:	74 de                	je     3ba <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3dc:	8b 45 08             	mov    0x8(%ebp),%eax
 3df:	0f b6 00             	movzbl (%eax),%eax
 3e2:	0f b6 d0             	movzbl %al,%edx
 3e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e8:	0f b6 00             	movzbl (%eax),%eax
 3eb:	0f b6 c0             	movzbl %al,%eax
 3ee:	29 c2                	sub    %eax,%edx
 3f0:	89 d0                	mov    %edx,%eax
}
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    

000003f4 <strlen>:

uint
strlen(char *s)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 401:	eb 04                	jmp    407 <strlen+0x13>
 403:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 407:	8b 55 fc             	mov    -0x4(%ebp),%edx
 40a:	8b 45 08             	mov    0x8(%ebp),%eax
 40d:	01 d0                	add    %edx,%eax
 40f:	0f b6 00             	movzbl (%eax),%eax
 412:	84 c0                	test   %al,%al
 414:	75 ed                	jne    403 <strlen+0xf>
    ;
  return n;
 416:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 419:	c9                   	leave  
 41a:	c3                   	ret    

0000041b <memset>:

void*
memset(void *dst, int c, uint n)
{
 41b:	55                   	push   %ebp
 41c:	89 e5                	mov    %esp,%ebp
 41e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 421:	8b 45 10             	mov    0x10(%ebp),%eax
 424:	89 44 24 08          	mov    %eax,0x8(%esp)
 428:	8b 45 0c             	mov    0xc(%ebp),%eax
 42b:	89 44 24 04          	mov    %eax,0x4(%esp)
 42f:	8b 45 08             	mov    0x8(%ebp),%eax
 432:	89 04 24             	mov    %eax,(%esp)
 435:	e8 26 ff ff ff       	call   360 <stosb>
  return dst;
 43a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 43d:	c9                   	leave  
 43e:	c3                   	ret    

0000043f <strchr>:

char*
strchr(const char *s, char c)
{
 43f:	55                   	push   %ebp
 440:	89 e5                	mov    %esp,%ebp
 442:	83 ec 04             	sub    $0x4,%esp
 445:	8b 45 0c             	mov    0xc(%ebp),%eax
 448:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 44b:	eb 14                	jmp    461 <strchr+0x22>
    if(*s == c)
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
 450:	0f b6 00             	movzbl (%eax),%eax
 453:	3a 45 fc             	cmp    -0x4(%ebp),%al
 456:	75 05                	jne    45d <strchr+0x1e>
      return (char*)s;
 458:	8b 45 08             	mov    0x8(%ebp),%eax
 45b:	eb 13                	jmp    470 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 45d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 461:	8b 45 08             	mov    0x8(%ebp),%eax
 464:	0f b6 00             	movzbl (%eax),%eax
 467:	84 c0                	test   %al,%al
 469:	75 e2                	jne    44d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 46b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 470:	c9                   	leave  
 471:	c3                   	ret    

00000472 <gets>:

char*
gets(char *buf, int max)
{
 472:	55                   	push   %ebp
 473:	89 e5                	mov    %esp,%ebp
 475:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 478:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 47f:	eb 4c                	jmp    4cd <gets+0x5b>
    cc = read(0, &c, 1);
 481:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 488:	00 
 489:	8d 45 ef             	lea    -0x11(%ebp),%eax
 48c:	89 44 24 04          	mov    %eax,0x4(%esp)
 490:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 497:	e8 44 01 00 00       	call   5e0 <read>
 49c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 49f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4a3:	7f 02                	jg     4a7 <gets+0x35>
      break;
 4a5:	eb 31                	jmp    4d8 <gets+0x66>
    buf[i++] = c;
 4a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4aa:	8d 50 01             	lea    0x1(%eax),%edx
 4ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4b0:	89 c2                	mov    %eax,%edx
 4b2:	8b 45 08             	mov    0x8(%ebp),%eax
 4b5:	01 c2                	add    %eax,%edx
 4b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4bb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 4bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4c1:	3c 0a                	cmp    $0xa,%al
 4c3:	74 13                	je     4d8 <gets+0x66>
 4c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4c9:	3c 0d                	cmp    $0xd,%al
 4cb:	74 0b                	je     4d8 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d0:	83 c0 01             	add    $0x1,%eax
 4d3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4d6:	7c a9                	jl     481 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4db:	8b 45 08             	mov    0x8(%ebp),%eax
 4de:	01 d0                	add    %edx,%eax
 4e0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4e6:	c9                   	leave  
 4e7:	c3                   	ret    

000004e8 <stat>:

int
stat(char *n, struct stat *st)
{
 4e8:	55                   	push   %ebp
 4e9:	89 e5                	mov    %esp,%ebp
 4eb:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4f5:	00 
 4f6:	8b 45 08             	mov    0x8(%ebp),%eax
 4f9:	89 04 24             	mov    %eax,(%esp)
 4fc:	e8 07 01 00 00       	call   608 <open>
 501:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 504:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 508:	79 07                	jns    511 <stat+0x29>
    return -1;
 50a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 50f:	eb 23                	jmp    534 <stat+0x4c>
  r = fstat(fd, st);
 511:	8b 45 0c             	mov    0xc(%ebp),%eax
 514:	89 44 24 04          	mov    %eax,0x4(%esp)
 518:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51b:	89 04 24             	mov    %eax,(%esp)
 51e:	e8 fd 00 00 00       	call   620 <fstat>
 523:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 526:	8b 45 f4             	mov    -0xc(%ebp),%eax
 529:	89 04 24             	mov    %eax,(%esp)
 52c:	e8 bf 00 00 00       	call   5f0 <close>
  return r;
 531:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 534:	c9                   	leave  
 535:	c3                   	ret    

00000536 <atoi>:

int
atoi(const char *s)
{
 536:	55                   	push   %ebp
 537:	89 e5                	mov    %esp,%ebp
 539:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 53c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 543:	eb 25                	jmp    56a <atoi+0x34>
    n = n*10 + *s++ - '0';
 545:	8b 55 fc             	mov    -0x4(%ebp),%edx
 548:	89 d0                	mov    %edx,%eax
 54a:	c1 e0 02             	shl    $0x2,%eax
 54d:	01 d0                	add    %edx,%eax
 54f:	01 c0                	add    %eax,%eax
 551:	89 c1                	mov    %eax,%ecx
 553:	8b 45 08             	mov    0x8(%ebp),%eax
 556:	8d 50 01             	lea    0x1(%eax),%edx
 559:	89 55 08             	mov    %edx,0x8(%ebp)
 55c:	0f b6 00             	movzbl (%eax),%eax
 55f:	0f be c0             	movsbl %al,%eax
 562:	01 c8                	add    %ecx,%eax
 564:	83 e8 30             	sub    $0x30,%eax
 567:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 56a:	8b 45 08             	mov    0x8(%ebp),%eax
 56d:	0f b6 00             	movzbl (%eax),%eax
 570:	3c 2f                	cmp    $0x2f,%al
 572:	7e 0a                	jle    57e <atoi+0x48>
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	0f b6 00             	movzbl (%eax),%eax
 57a:	3c 39                	cmp    $0x39,%al
 57c:	7e c7                	jle    545 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 57e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 581:	c9                   	leave  
 582:	c3                   	ret    

00000583 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 583:	55                   	push   %ebp
 584:	89 e5                	mov    %esp,%ebp
 586:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 589:	8b 45 08             	mov    0x8(%ebp),%eax
 58c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 58f:	8b 45 0c             	mov    0xc(%ebp),%eax
 592:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 595:	eb 17                	jmp    5ae <memmove+0x2b>
    *dst++ = *src++;
 597:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59a:	8d 50 01             	lea    0x1(%eax),%edx
 59d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 5a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 5a3:	8d 4a 01             	lea    0x1(%edx),%ecx
 5a6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5a9:	0f b6 12             	movzbl (%edx),%edx
 5ac:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5ae:	8b 45 10             	mov    0x10(%ebp),%eax
 5b1:	8d 50 ff             	lea    -0x1(%eax),%edx
 5b4:	89 55 10             	mov    %edx,0x10(%ebp)
 5b7:	85 c0                	test   %eax,%eax
 5b9:	7f dc                	jg     597 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5be:	c9                   	leave  
 5bf:	c3                   	ret    

000005c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5c0:	b8 01 00 00 00       	mov    $0x1,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <exit>:
SYSCALL(exit)
 5c8:	b8 02 00 00 00       	mov    $0x2,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <wait>:
SYSCALL(wait)
 5d0:	b8 03 00 00 00       	mov    $0x3,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <pipe>:
SYSCALL(pipe)
 5d8:	b8 04 00 00 00       	mov    $0x4,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <read>:
SYSCALL(read)
 5e0:	b8 05 00 00 00       	mov    $0x5,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <write>:
SYSCALL(write)
 5e8:	b8 10 00 00 00       	mov    $0x10,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <close>:
SYSCALL(close)
 5f0:	b8 15 00 00 00       	mov    $0x15,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <kill>:
SYSCALL(kill)
 5f8:	b8 06 00 00 00       	mov    $0x6,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <exec>:
SYSCALL(exec)
 600:	b8 07 00 00 00       	mov    $0x7,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <open>:
SYSCALL(open)
 608:	b8 0f 00 00 00       	mov    $0xf,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <mknod>:
SYSCALL(mknod)
 610:	b8 11 00 00 00       	mov    $0x11,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <unlink>:
SYSCALL(unlink)
 618:	b8 12 00 00 00       	mov    $0x12,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <fstat>:
SYSCALL(fstat)
 620:	b8 08 00 00 00       	mov    $0x8,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <link>:
SYSCALL(link)
 628:	b8 13 00 00 00       	mov    $0x13,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <mkdir>:
SYSCALL(mkdir)
 630:	b8 14 00 00 00       	mov    $0x14,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <chdir>:
SYSCALL(chdir)
 638:	b8 09 00 00 00       	mov    $0x9,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <dup>:
SYSCALL(dup)
 640:	b8 0a 00 00 00       	mov    $0xa,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <getpid>:
SYSCALL(getpid)
 648:	b8 0b 00 00 00       	mov    $0xb,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <sbrk>:
SYSCALL(sbrk)
 650:	b8 0c 00 00 00       	mov    $0xc,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <sleep>:
SYSCALL(sleep)
 658:	b8 0d 00 00 00       	mov    $0xd,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <uptime>:
SYSCALL(uptime)
 660:	b8 0e 00 00 00       	mov    $0xe,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    

00000668 <date>:
SYSCALL(date)
 668:	b8 16 00 00 00       	mov    $0x16,%eax
 66d:	cd 40                	int    $0x40
 66f:	c3                   	ret    

00000670 <clone>:
SYSCALL(clone)
 670:	b8 17 00 00 00       	mov    $0x17,%eax
 675:	cd 40                	int    $0x40
 677:	c3                   	ret    

00000678 <join>:
SYSCALL(join)
 678:	b8 18 00 00 00       	mov    $0x18,%eax
 67d:	cd 40                	int    $0x40
 67f:	c3                   	ret    

00000680 <threadSleep>:
SYSCALL(threadSleep)
 680:	b8 19 00 00 00       	mov    $0x19,%eax
 685:	cd 40                	int    $0x40
 687:	c3                   	ret    

00000688 <threadWake>:
SYSCALL(threadWake)
 688:	b8 1a 00 00 00       	mov    $0x1a,%eax
 68d:	cd 40                	int    $0x40
 68f:	c3                   	ret    

00000690 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	83 ec 18             	sub    $0x18,%esp
 696:	8b 45 0c             	mov    0xc(%ebp),%eax
 699:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 69c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a3:	00 
 6a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ab:	8b 45 08             	mov    0x8(%ebp),%eax
 6ae:	89 04 24             	mov    %eax,(%esp)
 6b1:	e8 32 ff ff ff       	call   5e8 <write>
}
 6b6:	c9                   	leave  
 6b7:	c3                   	ret    

000006b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b8:	55                   	push   %ebp
 6b9:	89 e5                	mov    %esp,%ebp
 6bb:	56                   	push   %esi
 6bc:	53                   	push   %ebx
 6bd:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6c7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6cb:	74 17                	je     6e4 <printint+0x2c>
 6cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6d1:	79 11                	jns    6e4 <printint+0x2c>
    neg = 1;
 6d3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6da:	8b 45 0c             	mov    0xc(%ebp),%eax
 6dd:	f7 d8                	neg    %eax
 6df:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6e2:	eb 06                	jmp    6ea <printint+0x32>
  } else {
    x = xx;
 6e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6f1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6f4:	8d 41 01             	lea    0x1(%ecx),%eax
 6f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 700:	ba 00 00 00 00       	mov    $0x0,%edx
 705:	f7 f3                	div    %ebx
 707:	89 d0                	mov    %edx,%eax
 709:	0f b6 80 98 12 00 00 	movzbl 0x1298(%eax),%eax
 710:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 714:	8b 75 10             	mov    0x10(%ebp),%esi
 717:	8b 45 ec             	mov    -0x14(%ebp),%eax
 71a:	ba 00 00 00 00       	mov    $0x0,%edx
 71f:	f7 f6                	div    %esi
 721:	89 45 ec             	mov    %eax,-0x14(%ebp)
 724:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 728:	75 c7                	jne    6f1 <printint+0x39>
  if(neg)
 72a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72e:	74 10                	je     740 <printint+0x88>
    buf[i++] = '-';
 730:	8b 45 f4             	mov    -0xc(%ebp),%eax
 733:	8d 50 01             	lea    0x1(%eax),%edx
 736:	89 55 f4             	mov    %edx,-0xc(%ebp)
 739:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 73e:	eb 1f                	jmp    75f <printint+0xa7>
 740:	eb 1d                	jmp    75f <printint+0xa7>
    putc(fd, buf[i]);
 742:	8d 55 dc             	lea    -0x24(%ebp),%edx
 745:	8b 45 f4             	mov    -0xc(%ebp),%eax
 748:	01 d0                	add    %edx,%eax
 74a:	0f b6 00             	movzbl (%eax),%eax
 74d:	0f be c0             	movsbl %al,%eax
 750:	89 44 24 04          	mov    %eax,0x4(%esp)
 754:	8b 45 08             	mov    0x8(%ebp),%eax
 757:	89 04 24             	mov    %eax,(%esp)
 75a:	e8 31 ff ff ff       	call   690 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 75f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 763:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 767:	79 d9                	jns    742 <printint+0x8a>
    putc(fd, buf[i]);
}
 769:	83 c4 30             	add    $0x30,%esp
 76c:	5b                   	pop    %ebx
 76d:	5e                   	pop    %esi
 76e:	5d                   	pop    %ebp
 76f:	c3                   	ret    

00000770 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 776:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 77d:	8d 45 0c             	lea    0xc(%ebp),%eax
 780:	83 c0 04             	add    $0x4,%eax
 783:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 786:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 78d:	e9 7c 01 00 00       	jmp    90e <printf+0x19e>
    c = fmt[i] & 0xff;
 792:	8b 55 0c             	mov    0xc(%ebp),%edx
 795:	8b 45 f0             	mov    -0x10(%ebp),%eax
 798:	01 d0                	add    %edx,%eax
 79a:	0f b6 00             	movzbl (%eax),%eax
 79d:	0f be c0             	movsbl %al,%eax
 7a0:	25 ff 00 00 00       	and    $0xff,%eax
 7a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7ac:	75 2c                	jne    7da <printf+0x6a>
      if(c == '%'){
 7ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7b2:	75 0c                	jne    7c0 <printf+0x50>
        state = '%';
 7b4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7bb:	e9 4a 01 00 00       	jmp    90a <printf+0x19a>
      } else {
        putc(fd, c);
 7c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7c3:	0f be c0             	movsbl %al,%eax
 7c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ca:	8b 45 08             	mov    0x8(%ebp),%eax
 7cd:	89 04 24             	mov    %eax,(%esp)
 7d0:	e8 bb fe ff ff       	call   690 <putc>
 7d5:	e9 30 01 00 00       	jmp    90a <printf+0x19a>
      }
    } else if(state == '%'){
 7da:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7de:	0f 85 26 01 00 00    	jne    90a <printf+0x19a>
      if(c == 'd'){
 7e4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7e8:	75 2d                	jne    817 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 7ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ed:	8b 00                	mov    (%eax),%eax
 7ef:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7f6:	00 
 7f7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7fe:	00 
 7ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 803:	8b 45 08             	mov    0x8(%ebp),%eax
 806:	89 04 24             	mov    %eax,(%esp)
 809:	e8 aa fe ff ff       	call   6b8 <printint>
        ap++;
 80e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 812:	e9 ec 00 00 00       	jmp    903 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 817:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 81b:	74 06                	je     823 <printf+0xb3>
 81d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 821:	75 2d                	jne    850 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 823:	8b 45 e8             	mov    -0x18(%ebp),%eax
 826:	8b 00                	mov    (%eax),%eax
 828:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 82f:	00 
 830:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 837:	00 
 838:	89 44 24 04          	mov    %eax,0x4(%esp)
 83c:	8b 45 08             	mov    0x8(%ebp),%eax
 83f:	89 04 24             	mov    %eax,(%esp)
 842:	e8 71 fe ff ff       	call   6b8 <printint>
        ap++;
 847:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 84b:	e9 b3 00 00 00       	jmp    903 <printf+0x193>
      } else if(c == 's'){
 850:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 854:	75 45                	jne    89b <printf+0x12b>
        s = (char*)*ap;
 856:	8b 45 e8             	mov    -0x18(%ebp),%eax
 859:	8b 00                	mov    (%eax),%eax
 85b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 85e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 862:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 866:	75 09                	jne    871 <printf+0x101>
          s = "(null)";
 868:	c7 45 f4 1a 0e 00 00 	movl   $0xe1a,-0xc(%ebp)
        while(*s != 0){
 86f:	eb 1e                	jmp    88f <printf+0x11f>
 871:	eb 1c                	jmp    88f <printf+0x11f>
          putc(fd, *s);
 873:	8b 45 f4             	mov    -0xc(%ebp),%eax
 876:	0f b6 00             	movzbl (%eax),%eax
 879:	0f be c0             	movsbl %al,%eax
 87c:	89 44 24 04          	mov    %eax,0x4(%esp)
 880:	8b 45 08             	mov    0x8(%ebp),%eax
 883:	89 04 24             	mov    %eax,(%esp)
 886:	e8 05 fe ff ff       	call   690 <putc>
          s++;
 88b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 892:	0f b6 00             	movzbl (%eax),%eax
 895:	84 c0                	test   %al,%al
 897:	75 da                	jne    873 <printf+0x103>
 899:	eb 68                	jmp    903 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 89b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 89f:	75 1d                	jne    8be <printf+0x14e>
        putc(fd, *ap);
 8a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8a4:	8b 00                	mov    (%eax),%eax
 8a6:	0f be c0             	movsbl %al,%eax
 8a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ad:	8b 45 08             	mov    0x8(%ebp),%eax
 8b0:	89 04 24             	mov    %eax,(%esp)
 8b3:	e8 d8 fd ff ff       	call   690 <putc>
        ap++;
 8b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8bc:	eb 45                	jmp    903 <printf+0x193>
      } else if(c == '%'){
 8be:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8c2:	75 17                	jne    8db <printf+0x16b>
        putc(fd, c);
 8c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c7:	0f be c0             	movsbl %al,%eax
 8ca:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ce:	8b 45 08             	mov    0x8(%ebp),%eax
 8d1:	89 04 24             	mov    %eax,(%esp)
 8d4:	e8 b7 fd ff ff       	call   690 <putc>
 8d9:	eb 28                	jmp    903 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8db:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 8e2:	00 
 8e3:	8b 45 08             	mov    0x8(%ebp),%eax
 8e6:	89 04 24             	mov    %eax,(%esp)
 8e9:	e8 a2 fd ff ff       	call   690 <putc>
        putc(fd, c);
 8ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8f1:	0f be c0             	movsbl %al,%eax
 8f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 8f8:	8b 45 08             	mov    0x8(%ebp),%eax
 8fb:	89 04 24             	mov    %eax,(%esp)
 8fe:	e8 8d fd ff ff       	call   690 <putc>
      }
      state = 0;
 903:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 90a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 90e:	8b 55 0c             	mov    0xc(%ebp),%edx
 911:	8b 45 f0             	mov    -0x10(%ebp),%eax
 914:	01 d0                	add    %edx,%eax
 916:	0f b6 00             	movzbl (%eax),%eax
 919:	84 c0                	test   %al,%al
 91b:	0f 85 71 fe ff ff    	jne    792 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 921:	c9                   	leave  
 922:	c3                   	ret    
 923:	90                   	nop

00000924 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 924:	55                   	push   %ebp
 925:	89 e5                	mov    %esp,%ebp
 927:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 92a:	8b 45 08             	mov    0x8(%ebp),%eax
 92d:	83 e8 08             	sub    $0x8,%eax
 930:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 933:	a1 c8 12 00 00       	mov    0x12c8,%eax
 938:	89 45 fc             	mov    %eax,-0x4(%ebp)
 93b:	eb 24                	jmp    961 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 940:	8b 00                	mov    (%eax),%eax
 942:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 945:	77 12                	ja     959 <free+0x35>
 947:	8b 45 f8             	mov    -0x8(%ebp),%eax
 94a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 94d:	77 24                	ja     973 <free+0x4f>
 94f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 952:	8b 00                	mov    (%eax),%eax
 954:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 957:	77 1a                	ja     973 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 959:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95c:	8b 00                	mov    (%eax),%eax
 95e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 961:	8b 45 f8             	mov    -0x8(%ebp),%eax
 964:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 967:	76 d4                	jbe    93d <free+0x19>
 969:	8b 45 fc             	mov    -0x4(%ebp),%eax
 96c:	8b 00                	mov    (%eax),%eax
 96e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 971:	76 ca                	jbe    93d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 973:	8b 45 f8             	mov    -0x8(%ebp),%eax
 976:	8b 40 04             	mov    0x4(%eax),%eax
 979:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 980:	8b 45 f8             	mov    -0x8(%ebp),%eax
 983:	01 c2                	add    %eax,%edx
 985:	8b 45 fc             	mov    -0x4(%ebp),%eax
 988:	8b 00                	mov    (%eax),%eax
 98a:	39 c2                	cmp    %eax,%edx
 98c:	75 24                	jne    9b2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 98e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 991:	8b 50 04             	mov    0x4(%eax),%edx
 994:	8b 45 fc             	mov    -0x4(%ebp),%eax
 997:	8b 00                	mov    (%eax),%eax
 999:	8b 40 04             	mov    0x4(%eax),%eax
 99c:	01 c2                	add    %eax,%edx
 99e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a7:	8b 00                	mov    (%eax),%eax
 9a9:	8b 10                	mov    (%eax),%edx
 9ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ae:	89 10                	mov    %edx,(%eax)
 9b0:	eb 0a                	jmp    9bc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b5:	8b 10                	mov    (%eax),%edx
 9b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ba:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bf:	8b 40 04             	mov    0x4(%eax),%eax
 9c2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9cc:	01 d0                	add    %edx,%eax
 9ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9d1:	75 20                	jne    9f3 <free+0xcf>
    p->s.size += bp->s.size;
 9d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d6:	8b 50 04             	mov    0x4(%eax),%edx
 9d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9dc:	8b 40 04             	mov    0x4(%eax),%eax
 9df:	01 c2                	add    %eax,%edx
 9e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ea:	8b 10                	mov    (%eax),%edx
 9ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ef:	89 10                	mov    %edx,(%eax)
 9f1:	eb 08                	jmp    9fb <free+0xd7>
  } else
    p->s.ptr = bp;
 9f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9f9:	89 10                	mov    %edx,(%eax)
  freep = p;
 9fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9fe:	a3 c8 12 00 00       	mov    %eax,0x12c8
}
 a03:	c9                   	leave  
 a04:	c3                   	ret    

00000a05 <morecore>:

static Header*
morecore(uint nu)
{
 a05:	55                   	push   %ebp
 a06:	89 e5                	mov    %esp,%ebp
 a08:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a0b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a12:	77 07                	ja     a1b <morecore+0x16>
    nu = 4096;
 a14:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a1b:	8b 45 08             	mov    0x8(%ebp),%eax
 a1e:	c1 e0 03             	shl    $0x3,%eax
 a21:	89 04 24             	mov    %eax,(%esp)
 a24:	e8 27 fc ff ff       	call   650 <sbrk>
 a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a2c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a30:	75 07                	jne    a39 <morecore+0x34>
    return 0;
 a32:	b8 00 00 00 00       	mov    $0x0,%eax
 a37:	eb 22                	jmp    a5b <morecore+0x56>
  hp = (Header*)p;
 a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a42:	8b 55 08             	mov    0x8(%ebp),%edx
 a45:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a4b:	83 c0 08             	add    $0x8,%eax
 a4e:	89 04 24             	mov    %eax,(%esp)
 a51:	e8 ce fe ff ff       	call   924 <free>
  return freep;
 a56:	a1 c8 12 00 00       	mov    0x12c8,%eax
}
 a5b:	c9                   	leave  
 a5c:	c3                   	ret    

00000a5d <malloc>:

void*
malloc(uint nbytes)
{
 a5d:	55                   	push   %ebp
 a5e:	89 e5                	mov    %esp,%ebp
 a60:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a63:	8b 45 08             	mov    0x8(%ebp),%eax
 a66:	83 c0 07             	add    $0x7,%eax
 a69:	c1 e8 03             	shr    $0x3,%eax
 a6c:	83 c0 01             	add    $0x1,%eax
 a6f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a72:	a1 c8 12 00 00       	mov    0x12c8,%eax
 a77:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a7a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a7e:	75 23                	jne    aa3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a80:	c7 45 f0 c0 12 00 00 	movl   $0x12c0,-0x10(%ebp)
 a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a8a:	a3 c8 12 00 00       	mov    %eax,0x12c8
 a8f:	a1 c8 12 00 00       	mov    0x12c8,%eax
 a94:	a3 c0 12 00 00       	mov    %eax,0x12c0
    base.s.size = 0;
 a99:	c7 05 c4 12 00 00 00 	movl   $0x0,0x12c4
 aa0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa6:	8b 00                	mov    (%eax),%eax
 aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aae:	8b 40 04             	mov    0x4(%eax),%eax
 ab1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 ab4:	72 4d                	jb     b03 <malloc+0xa6>
      if(p->s.size == nunits)
 ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab9:	8b 40 04             	mov    0x4(%eax),%eax
 abc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 abf:	75 0c                	jne    acd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac4:	8b 10                	mov    (%eax),%edx
 ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac9:	89 10                	mov    %edx,(%eax)
 acb:	eb 26                	jmp    af3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad0:	8b 40 04             	mov    0x4(%eax),%eax
 ad3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ad6:	89 c2                	mov    %eax,%edx
 ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae1:	8b 40 04             	mov    0x4(%eax),%eax
 ae4:	c1 e0 03             	shl    $0x3,%eax
 ae7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aed:	8b 55 ec             	mov    -0x14(%ebp),%edx
 af0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 af3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af6:	a3 c8 12 00 00       	mov    %eax,0x12c8
      return (void*)(p + 1);
 afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afe:	83 c0 08             	add    $0x8,%eax
 b01:	eb 38                	jmp    b3b <malloc+0xde>
    }
    if(p == freep)
 b03:	a1 c8 12 00 00       	mov    0x12c8,%eax
 b08:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b0b:	75 1b                	jne    b28 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 b0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b10:	89 04 24             	mov    %eax,(%esp)
 b13:	e8 ed fe ff ff       	call   a05 <morecore>
 b18:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b1f:	75 07                	jne    b28 <malloc+0xcb>
        return 0;
 b21:	b8 00 00 00 00       	mov    $0x0,%eax
 b26:	eb 13                	jmp    b3b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b31:	8b 00                	mov    (%eax),%eax
 b33:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b36:	e9 70 ff ff ff       	jmp    aab <malloc+0x4e>
}
 b3b:	c9                   	leave  
 b3c:	c3                   	ret    
 b3d:	66 90                	xchg   %ax,%ax
 b3f:	90                   	nop

00000b40 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 b40:	55                   	push   %ebp
 b41:	89 e5                	mov    %esp,%ebp
 b43:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 b46:	8b 55 08             	mov    0x8(%ebp),%edx
 b49:	8b 45 0c             	mov    0xc(%ebp),%eax
 b4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 b4f:	f0 87 02             	lock xchg %eax,(%edx)
 b52:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 b55:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 b58:	c9                   	leave  
 b59:	c3                   	ret    

00000b5a <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 b5a:	55                   	push   %ebp
 b5b:	89 e5                	mov    %esp,%ebp
 b5d:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 b60:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 b67:	e8 f1 fe ff ff       	call   a5d <malloc>
 b6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b72:	85 c0                	test   %eax,%eax
 b74:	75 1b                	jne    b91 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 b76:	c7 44 24 04 24 0e 00 	movl   $0xe24,0x4(%esp)
 b7d:	00 
 b7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b85:	e8 e6 fb ff ff       	call   770 <printf>
    return -1;
 b8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b8f:	eb 43                	jmp    bd4 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b94:	25 ff 0f 00 00       	and    $0xfff,%eax
 b99:	85 c0                	test   %eax,%eax
 b9b:	74 14                	je     bb1 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba0:	25 ff 0f 00 00       	and    $0xfff,%eax
 ba5:	89 c2                	mov    %eax,%edx
 ba7:	b8 00 10 00 00       	mov    $0x1000,%eax
 bac:	29 d0                	sub    %edx,%eax
 bae:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bb4:	89 44 24 08          	mov    %eax,0x8(%esp)
 bb8:	8b 45 14             	mov    0x14(%ebp),%eax
 bbb:	89 44 24 04          	mov    %eax,0x4(%esp)
 bbf:	8b 45 10             	mov    0x10(%ebp),%eax
 bc2:	89 04 24             	mov    %eax,(%esp)
 bc5:	e8 a6 fa ff ff       	call   670 <clone>
 bca:	8b 55 08             	mov    0x8(%ebp),%edx
 bcd:	89 02                	mov    %eax,(%edx)
  return *thread;
 bcf:	8b 45 08             	mov    0x8(%ebp),%eax
 bd2:	8b 00                	mov    (%eax),%eax
}
 bd4:	c9                   	leave  
 bd5:	c3                   	ret    

00000bd6 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 bd6:	55                   	push   %ebp
 bd7:	89 e5                	mov    %esp,%ebp
 bd9:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 bdc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
 be3:	8b 45 08             	mov    0x8(%ebp),%eax
 be6:	89 04 24             	mov    %eax,(%esp)
 be9:	e8 8a fa ff ff       	call   678 <join>
 bee:	85 c0                	test   %eax,%eax
 bf0:	79 07                	jns    bf9 <pthread_join+0x23>
    return -1;
 bf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 bf7:	eb 10                	jmp    c09 <pthread_join+0x33>
  }
  free(stack);
 bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bfc:	89 04 24             	mov    %eax,(%esp)
 bff:	e8 20 fd ff ff       	call   924 <free>
  return 0;
 c04:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c09:	c9                   	leave  
 c0a:	c3                   	ret    

00000c0b <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 c0b:	55                   	push   %ebp
 c0c:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 c0e:	8b 45 08             	mov    0x8(%ebp),%eax
 c11:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 c17:	90                   	nop
}
 c18:	5d                   	pop    %ebp
 c19:	c3                   	ret    

00000c1a <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 c1a:	55                   	push   %ebp
 c1b:	89 e5                	mov    %esp,%ebp
 c1d:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 c20:	90                   	nop
 c21:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 c28:	00 
 c29:	8b 45 08             	mov    0x8(%ebp),%eax
 c2c:	89 04 24             	mov    %eax,(%esp)
 c2f:	e8 0c ff ff ff       	call   b40 <xchg>
 c34:	85 c0                	test   %eax,%eax
 c36:	75 e9                	jne    c21 <pthread_mutex_lock+0x7>
  return;
 c38:	90                   	nop
}
 c39:	c9                   	leave  
 c3a:	c3                   	ret    

00000c3b <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 c3b:	55                   	push   %ebp
 c3c:	89 e5                	mov    %esp,%ebp
 c3e:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 c41:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 c48:	00 
 c49:	8b 45 08             	mov    0x8(%ebp),%eax
 c4c:	89 04 24             	mov    %eax,(%esp)
 c4f:	e8 ec fe ff ff       	call   b40 <xchg>
  return;
 c54:	90                   	nop
}
 c55:	c9                   	leave  
 c56:	c3                   	ret    

00000c57 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 c57:	55                   	push   %ebp
 c58:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 c5a:	8b 45 08             	mov    0x8(%ebp),%eax
 c5d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 c63:	8b 45 08             	mov    0x8(%ebp),%eax
 c66:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 c6d:	90                   	nop
}
 c6e:	5d                   	pop    %ebp
 c6f:	c3                   	ret    

00000c70 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 c70:	55                   	push   %ebp
 c71:	89 e5                	mov    %esp,%ebp
 c73:	53                   	push   %ebx
 c74:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 c77:	8b 45 08             	mov    0x8(%ebp),%eax
 c7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
 c80:	89 04 24             	mov    %eax,(%esp)
 c83:	e8 b3 ff ff ff       	call   c3b <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 c88:	eb 09                	jmp    c93 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c8d:	8b 40 04             	mov    0x4(%eax),%eax
 c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c96:	8b 40 04             	mov    0x4(%eax),%eax
 c99:	85 c0                	test   %eax,%eax
 c9b:	75 ed                	jne    c8a <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 c9d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 ca4:	e8 b4 fd ff ff       	call   a5d <malloc>
 ca9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 cac:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 caf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cb2:	8b 58 04             	mov    0x4(%eax),%ebx
 cb5:	e8 8e f9 ff ff       	call   648 <getpid>
 cba:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 cbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cbf:	8b 40 04             	mov    0x4(%eax),%eax
 cc2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
 ccc:	89 04 24             	mov    %eax,(%esp)
 ccf:	e8 46 ff ff ff       	call   c1a <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
 cd7:	89 04 24             	mov    %eax,(%esp)
 cda:	e8 5c ff ff ff       	call   c3b <pthread_mutex_unlock>
  threadSleep(mutex);
 cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
 ce2:	89 04 24             	mov    %eax,(%esp)
 ce5:	e8 96 f9 ff ff       	call   680 <threadSleep>
  pthread_mutex_lock(mutex);
 cea:	8b 45 0c             	mov    0xc(%ebp),%eax
 ced:	89 04 24             	mov    %eax,(%esp)
 cf0:	e8 25 ff ff ff       	call   c1a <pthread_mutex_lock>
  return;
 cf5:	90                   	nop
}
 cf6:	83 c4 24             	add    $0x24,%esp
 cf9:	5b                   	pop    %ebx
 cfa:	5d                   	pop    %ebp
 cfb:	c3                   	ret    

00000cfc <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 cfc:	55                   	push   %ebp
 cfd:	89 e5                	mov    %esp,%ebp
 cff:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 d02:	8b 45 08             	mov    0x8(%ebp),%eax
 d05:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 d08:	eb 09                	jmp    d13 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 d0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d0d:	8b 40 04             	mov    0x4(%eax),%eax
 d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d16:	8b 00                	mov    (%eax),%eax
 d18:	83 f8 ff             	cmp    $0xffffffff,%eax
 d1b:	74 ed                	je     d0a <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 d1d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d21:	74 33                	je     d56 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 d23:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d26:	8b 00                	mov    (%eax),%eax
 d28:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 d2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 d31:	8b 45 08             	mov    0x8(%ebp),%eax
 d34:	8b 40 04             	mov    0x4(%eax),%eax
 d37:	8b 50 04             	mov    0x4(%eax),%edx
 d3a:	8b 45 08             	mov    0x8(%ebp),%eax
 d3d:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 d40:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d43:	89 04 24             	mov    %eax,(%esp)
 d46:	e8 d9 fb ff ff       	call   924 <free>
    threadWake(threadId);
 d4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d4e:	89 04 24             	mov    %eax,(%esp)
 d51:	e8 32 f9 ff ff       	call   688 <threadWake>
  }
  return;
 d56:	90                   	nop
}
 d57:	c9                   	leave  
 d58:	c3                   	ret    

00000d59 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 d59:	55                   	push   %ebp
 d5a:	89 e5                	mov    %esp,%ebp
 d5c:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 d5f:	8b 45 08             	mov    0x8(%ebp),%eax
 d62:	8b 55 10             	mov    0x10(%ebp),%edx
 d65:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 d67:	8b 45 08             	mov    0x8(%ebp),%eax
 d6a:	83 c0 04             	add    $0x4,%eax
 d6d:	89 04 24             	mov    %eax,(%esp)
 d70:	e8 e2 fe ff ff       	call   c57 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 d75:	8b 45 08             	mov    0x8(%ebp),%eax
 d78:	83 c0 0c             	add    $0xc,%eax
 d7b:	89 04 24             	mov    %eax,(%esp)
 d7e:	e8 88 fe ff ff       	call   c0b <pthread_mutex_init>
  return;
 d83:	90                   	nop
}
 d84:	c9                   	leave  
 d85:	c3                   	ret    

00000d86 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 d86:	55                   	push   %ebp
 d87:	89 e5                	mov    %esp,%ebp
 d89:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 d8c:	8b 45 08             	mov    0x8(%ebp),%eax
 d8f:	8b 00                	mov    (%eax),%eax
 d91:	8d 50 ff             	lea    -0x1(%eax),%edx
 d94:	8b 45 08             	mov    0x8(%ebp),%eax
 d97:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 d99:	8b 45 08             	mov    0x8(%ebp),%eax
 d9c:	8b 00                	mov    (%eax),%eax
 d9e:	85 c0                	test   %eax,%eax
 da0:	79 18                	jns    dba <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 da2:	8b 45 08             	mov    0x8(%ebp),%eax
 da5:	8d 50 0c             	lea    0xc(%eax),%edx
 da8:	8b 45 08             	mov    0x8(%ebp),%eax
 dab:	83 c0 04             	add    $0x4,%eax
 dae:	89 54 24 04          	mov    %edx,0x4(%esp)
 db2:	89 04 24             	mov    %eax,(%esp)
 db5:	e8 b6 fe ff ff       	call   c70 <pthread_cond_wait>
  }
  return;
 dba:	90                   	nop
}
 dbb:	c9                   	leave  
 dbc:	c3                   	ret    

00000dbd <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 dbd:	55                   	push   %ebp
 dbe:	89 e5                	mov    %esp,%ebp
 dc0:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 dc3:	8b 45 08             	mov    0x8(%ebp),%eax
 dc6:	8b 00                	mov    (%eax),%eax
 dc8:	8d 50 01             	lea    0x1(%eax),%edx
 dcb:	8b 45 08             	mov    0x8(%ebp),%eax
 dce:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 dd0:	8b 45 08             	mov    0x8(%ebp),%eax
 dd3:	83 c0 04             	add    $0x4,%eax
 dd6:	89 04 24             	mov    %eax,(%esp)
 dd9:	e8 1e ff ff ff       	call   cfc <pthread_cond_signal>
  return;
 dde:	90                   	nop
}
 ddf:	c9                   	leave  
 de0:	c3                   	ret    
