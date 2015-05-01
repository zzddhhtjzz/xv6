
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 1){
   9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "usage: kill pid...\n");
   f:	c7 44 24 04 ec 0a 00 	movl   $0xaec,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 55 04 00 00       	call   478 <printf>
    exit();
  23:	e8 a8 02 00 00       	call   2d0 <exit>
  }
  for(i=1; i<argc; i++)
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 27                	jmp    59 <main+0x59>
    kill(atoi(argv[i]));
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 f2 01 00 00       	call   23e <atoi>
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 ac 02 00 00       	call   300 <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  54:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  59:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5d:	3b 45 08             	cmp    0x8(%ebp),%eax
  60:	7c d0                	jl     32 <main+0x32>
    kill(atoi(argv[i]));
  exit();
  62:	e8 69 02 00 00       	call   2d0 <exit>
  67:	90                   	nop

00000068 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	57                   	push   %edi
  6c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  70:	8b 55 10             	mov    0x10(%ebp),%edx
  73:	8b 45 0c             	mov    0xc(%ebp),%eax
  76:	89 cb                	mov    %ecx,%ebx
  78:	89 df                	mov    %ebx,%edi
  7a:	89 d1                	mov    %edx,%ecx
  7c:	fc                   	cld    
  7d:	f3 aa                	rep stos %al,%es:(%edi)
  7f:	89 ca                	mov    %ecx,%edx
  81:	89 fb                	mov    %edi,%ebx
  83:	89 5d 08             	mov    %ebx,0x8(%ebp)
  86:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  89:	5b                   	pop    %ebx
  8a:	5f                   	pop    %edi
  8b:	5d                   	pop    %ebp
  8c:	c3                   	ret    

0000008d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8d:	55                   	push   %ebp
  8e:	89 e5                	mov    %esp,%ebp
  90:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  99:	90                   	nop
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	8d 50 01             	lea    0x1(%eax),%edx
  a0:	89 55 08             	mov    %edx,0x8(%ebp)
  a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  a6:	8d 4a 01             	lea    0x1(%edx),%ecx
  a9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  ac:	0f b6 12             	movzbl (%edx),%edx
  af:	88 10                	mov    %dl,(%eax)
  b1:	0f b6 00             	movzbl (%eax),%eax
  b4:	84 c0                	test   %al,%al
  b6:	75 e2                	jne    9a <strcpy+0xd>
    ;
  return os;
  b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bb:	c9                   	leave  
  bc:	c3                   	ret    

000000bd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bd:	55                   	push   %ebp
  be:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c0:	eb 08                	jmp    ca <strcmp+0xd>
    p++, q++;
  c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ca:	8b 45 08             	mov    0x8(%ebp),%eax
  cd:	0f b6 00             	movzbl (%eax),%eax
  d0:	84 c0                	test   %al,%al
  d2:	74 10                	je     e4 <strcmp+0x27>
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 10             	movzbl (%eax),%edx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	0f b6 00             	movzbl (%eax),%eax
  e0:	38 c2                	cmp    %al,%dl
  e2:	74 de                	je     c2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e4:	8b 45 08             	mov    0x8(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	0f b6 d0             	movzbl %al,%edx
  ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  f0:	0f b6 00             	movzbl (%eax),%eax
  f3:	0f b6 c0             	movzbl %al,%eax
  f6:	29 c2                	sub    %eax,%edx
  f8:	89 d0                	mov    %edx,%eax
}
  fa:	5d                   	pop    %ebp
  fb:	c3                   	ret    

000000fc <strlen>:

uint
strlen(char *s)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 102:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 109:	eb 04                	jmp    10f <strlen+0x13>
 10b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 112:	8b 45 08             	mov    0x8(%ebp),%eax
 115:	01 d0                	add    %edx,%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	84 c0                	test   %al,%al
 11c:	75 ed                	jne    10b <strlen+0xf>
    ;
  return n;
 11e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 121:	c9                   	leave  
 122:	c3                   	ret    

00000123 <memset>:

void*
memset(void *dst, int c, uint n)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 129:	8b 45 10             	mov    0x10(%ebp),%eax
 12c:	89 44 24 08          	mov    %eax,0x8(%esp)
 130:	8b 45 0c             	mov    0xc(%ebp),%eax
 133:	89 44 24 04          	mov    %eax,0x4(%esp)
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	89 04 24             	mov    %eax,(%esp)
 13d:	e8 26 ff ff ff       	call   68 <stosb>
  return dst;
 142:	8b 45 08             	mov    0x8(%ebp),%eax
}
 145:	c9                   	leave  
 146:	c3                   	ret    

00000147 <strchr>:

char*
strchr(const char *s, char c)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 04             	sub    $0x4,%esp
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 153:	eb 14                	jmp    169 <strchr+0x22>
    if(*s == c)
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15e:	75 05                	jne    165 <strchr+0x1e>
      return (char*)s;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	eb 13                	jmp    178 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 e2                	jne    155 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 173:	b8 00 00 00 00       	mov    $0x0,%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <gets>:

char*
gets(char *buf, int max)
{
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 187:	eb 4c                	jmp    1d5 <gets+0x5b>
    cc = read(0, &c, 1);
 189:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 190:	00 
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	89 44 24 04          	mov    %eax,0x4(%esp)
 198:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19f:	e8 44 01 00 00       	call   2e8 <read>
 1a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ab:	7f 02                	jg     1af <gets+0x35>
      break;
 1ad:	eb 31                	jmp    1e0 <gets+0x66>
    buf[i++] = c;
 1af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b2:	8d 50 01             	lea    0x1(%eax),%edx
 1b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b8:	89 c2                	mov    %eax,%edx
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	01 c2                	add    %eax,%edx
 1bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 13                	je     1e0 <gets+0x66>
 1cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d1:	3c 0d                	cmp    $0xd,%al
 1d3:	74 0b                	je     1e0 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d8:	83 c0 01             	add    $0x1,%eax
 1db:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1de:	7c a9                	jl     189 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	01 d0                	add    %edx,%eax
 1e8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ee:	c9                   	leave  
 1ef:	c3                   	ret    

000001f0 <stat>:

int
stat(char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1fd:	00 
 1fe:	8b 45 08             	mov    0x8(%ebp),%eax
 201:	89 04 24             	mov    %eax,(%esp)
 204:	e8 07 01 00 00       	call   310 <open>
 209:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 210:	79 07                	jns    219 <stat+0x29>
    return -1;
 212:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 217:	eb 23                	jmp    23c <stat+0x4c>
  r = fstat(fd, st);
 219:	8b 45 0c             	mov    0xc(%ebp),%eax
 21c:	89 44 24 04          	mov    %eax,0x4(%esp)
 220:	8b 45 f4             	mov    -0xc(%ebp),%eax
 223:	89 04 24             	mov    %eax,(%esp)
 226:	e8 fd 00 00 00       	call   328 <fstat>
 22b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 231:	89 04 24             	mov    %eax,(%esp)
 234:	e8 bf 00 00 00       	call   2f8 <close>
  return r;
 239:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23c:	c9                   	leave  
 23d:	c3                   	ret    

0000023e <atoi>:

int
atoi(const char *s)
{
 23e:	55                   	push   %ebp
 23f:	89 e5                	mov    %esp,%ebp
 241:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 244:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24b:	eb 25                	jmp    272 <atoi+0x34>
    n = n*10 + *s++ - '0';
 24d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 250:	89 d0                	mov    %edx,%eax
 252:	c1 e0 02             	shl    $0x2,%eax
 255:	01 d0                	add    %edx,%eax
 257:	01 c0                	add    %eax,%eax
 259:	89 c1                	mov    %eax,%ecx
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	8d 50 01             	lea    0x1(%eax),%edx
 261:	89 55 08             	mov    %edx,0x8(%ebp)
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	0f be c0             	movsbl %al,%eax
 26a:	01 c8                	add    %ecx,%eax
 26c:	83 e8 30             	sub    $0x30,%eax
 26f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	0f b6 00             	movzbl (%eax),%eax
 278:	3c 2f                	cmp    $0x2f,%al
 27a:	7e 0a                	jle    286 <atoi+0x48>
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
 27f:	0f b6 00             	movzbl (%eax),%eax
 282:	3c 39                	cmp    $0x39,%al
 284:	7e c7                	jle    24d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 286:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 297:	8b 45 0c             	mov    0xc(%ebp),%eax
 29a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29d:	eb 17                	jmp    2b6 <memmove+0x2b>
    *dst++ = *src++;
 29f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a2:	8d 50 01             	lea    0x1(%eax),%edx
 2a5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2ab:	8d 4a 01             	lea    0x1(%edx),%ecx
 2ae:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b1:	0f b6 12             	movzbl (%edx),%edx
 2b4:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b6:	8b 45 10             	mov    0x10(%ebp),%eax
 2b9:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bc:	89 55 10             	mov    %edx,0x10(%ebp)
 2bf:	85 c0                	test   %eax,%eax
 2c1:	7f dc                	jg     29f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c6:	c9                   	leave  
 2c7:	c3                   	ret    

000002c8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c8:	b8 01 00 00 00       	mov    $0x1,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <exit>:
SYSCALL(exit)
 2d0:	b8 02 00 00 00       	mov    $0x2,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <wait>:
SYSCALL(wait)
 2d8:	b8 03 00 00 00       	mov    $0x3,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <pipe>:
SYSCALL(pipe)
 2e0:	b8 04 00 00 00       	mov    $0x4,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <read>:
SYSCALL(read)
 2e8:	b8 05 00 00 00       	mov    $0x5,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <write>:
SYSCALL(write)
 2f0:	b8 10 00 00 00       	mov    $0x10,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <close>:
SYSCALL(close)
 2f8:	b8 15 00 00 00       	mov    $0x15,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <kill>:
SYSCALL(kill)
 300:	b8 06 00 00 00       	mov    $0x6,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <exec>:
SYSCALL(exec)
 308:	b8 07 00 00 00       	mov    $0x7,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <open>:
SYSCALL(open)
 310:	b8 0f 00 00 00       	mov    $0xf,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <mknod>:
SYSCALL(mknod)
 318:	b8 11 00 00 00       	mov    $0x11,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <unlink>:
SYSCALL(unlink)
 320:	b8 12 00 00 00       	mov    $0x12,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <fstat>:
SYSCALL(fstat)
 328:	b8 08 00 00 00       	mov    $0x8,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <link>:
SYSCALL(link)
 330:	b8 13 00 00 00       	mov    $0x13,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <mkdir>:
SYSCALL(mkdir)
 338:	b8 14 00 00 00       	mov    $0x14,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <chdir>:
SYSCALL(chdir)
 340:	b8 09 00 00 00       	mov    $0x9,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <dup>:
SYSCALL(dup)
 348:	b8 0a 00 00 00       	mov    $0xa,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <getpid>:
SYSCALL(getpid)
 350:	b8 0b 00 00 00       	mov    $0xb,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sbrk>:
SYSCALL(sbrk)
 358:	b8 0c 00 00 00       	mov    $0xc,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <sleep>:
SYSCALL(sleep)
 360:	b8 0d 00 00 00       	mov    $0xd,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <uptime>:
SYSCALL(uptime)
 368:	b8 0e 00 00 00       	mov    $0xe,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <date>:
SYSCALL(date)
 370:	b8 16 00 00 00       	mov    $0x16,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <clone>:
SYSCALL(clone)
 378:	b8 17 00 00 00       	mov    $0x17,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <join>:
SYSCALL(join)
 380:	b8 18 00 00 00       	mov    $0x18,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <threadSleep>:
SYSCALL(threadSleep)
 388:	b8 19 00 00 00       	mov    $0x19,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <threadWake>:
SYSCALL(threadWake)
 390:	b8 1a 00 00 00       	mov    $0x1a,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
 39b:	83 ec 18             	sub    $0x18,%esp
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3ab:	00 
 3ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3af:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	89 04 24             	mov    %eax,(%esp)
 3b9:	e8 32 ff ff ff       	call   2f0 <write>
}
 3be:	c9                   	leave  
 3bf:	c3                   	ret    

000003c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	53                   	push   %ebx
 3c5:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3cf:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3d3:	74 17                	je     3ec <printint+0x2c>
 3d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d9:	79 11                	jns    3ec <printint+0x2c>
    neg = 1;
 3db:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e5:	f7 d8                	neg    %eax
 3e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ea:	eb 06                	jmp    3f2 <printint+0x32>
  } else {
    x = xx;
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3fc:	8d 41 01             	lea    0x1(%ecx),%eax
 3ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
 402:	8b 5d 10             	mov    0x10(%ebp),%ebx
 405:	8b 45 ec             	mov    -0x14(%ebp),%eax
 408:	ba 00 00 00 00       	mov    $0x0,%edx
 40d:	f7 f3                	div    %ebx
 40f:	89 d0                	mov    %edx,%eax
 411:	0f b6 80 fc 0e 00 00 	movzbl 0xefc(%eax),%eax
 418:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 41c:	8b 75 10             	mov    0x10(%ebp),%esi
 41f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 422:	ba 00 00 00 00       	mov    $0x0,%edx
 427:	f7 f6                	div    %esi
 429:	89 45 ec             	mov    %eax,-0x14(%ebp)
 42c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 430:	75 c7                	jne    3f9 <printint+0x39>
  if(neg)
 432:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 436:	74 10                	je     448 <printint+0x88>
    buf[i++] = '-';
 438:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43b:	8d 50 01             	lea    0x1(%eax),%edx
 43e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 441:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 446:	eb 1f                	jmp    467 <printint+0xa7>
 448:	eb 1d                	jmp    467 <printint+0xa7>
    putc(fd, buf[i]);
 44a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 44d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 450:	01 d0                	add    %edx,%eax
 452:	0f b6 00             	movzbl (%eax),%eax
 455:	0f be c0             	movsbl %al,%eax
 458:	89 44 24 04          	mov    %eax,0x4(%esp)
 45c:	8b 45 08             	mov    0x8(%ebp),%eax
 45f:	89 04 24             	mov    %eax,(%esp)
 462:	e8 31 ff ff ff       	call   398 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 467:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 46b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 46f:	79 d9                	jns    44a <printint+0x8a>
    putc(fd, buf[i]);
}
 471:	83 c4 30             	add    $0x30,%esp
 474:	5b                   	pop    %ebx
 475:	5e                   	pop    %esi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    

00000478 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 478:	55                   	push   %ebp
 479:	89 e5                	mov    %esp,%ebp
 47b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 47e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 485:	8d 45 0c             	lea    0xc(%ebp),%eax
 488:	83 c0 04             	add    $0x4,%eax
 48b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 48e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 495:	e9 7c 01 00 00       	jmp    616 <printf+0x19e>
    c = fmt[i] & 0xff;
 49a:	8b 55 0c             	mov    0xc(%ebp),%edx
 49d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4a0:	01 d0                	add    %edx,%eax
 4a2:	0f b6 00             	movzbl (%eax),%eax
 4a5:	0f be c0             	movsbl %al,%eax
 4a8:	25 ff 00 00 00       	and    $0xff,%eax
 4ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b4:	75 2c                	jne    4e2 <printf+0x6a>
      if(c == '%'){
 4b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ba:	75 0c                	jne    4c8 <printf+0x50>
        state = '%';
 4bc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4c3:	e9 4a 01 00 00       	jmp    612 <printf+0x19a>
      } else {
        putc(fd, c);
 4c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4cb:	0f be c0             	movsbl %al,%eax
 4ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d2:	8b 45 08             	mov    0x8(%ebp),%eax
 4d5:	89 04 24             	mov    %eax,(%esp)
 4d8:	e8 bb fe ff ff       	call   398 <putc>
 4dd:	e9 30 01 00 00       	jmp    612 <printf+0x19a>
      }
    } else if(state == '%'){
 4e2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4e6:	0f 85 26 01 00 00    	jne    612 <printf+0x19a>
      if(c == 'd'){
 4ec:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4f0:	75 2d                	jne    51f <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f5:	8b 00                	mov    (%eax),%eax
 4f7:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4fe:	00 
 4ff:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 506:	00 
 507:	89 44 24 04          	mov    %eax,0x4(%esp)
 50b:	8b 45 08             	mov    0x8(%ebp),%eax
 50e:	89 04 24             	mov    %eax,(%esp)
 511:	e8 aa fe ff ff       	call   3c0 <printint>
        ap++;
 516:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 51a:	e9 ec 00 00 00       	jmp    60b <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 51f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 523:	74 06                	je     52b <printf+0xb3>
 525:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 529:	75 2d                	jne    558 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 52b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52e:	8b 00                	mov    (%eax),%eax
 530:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 537:	00 
 538:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 53f:	00 
 540:	89 44 24 04          	mov    %eax,0x4(%esp)
 544:	8b 45 08             	mov    0x8(%ebp),%eax
 547:	89 04 24             	mov    %eax,(%esp)
 54a:	e8 71 fe ff ff       	call   3c0 <printint>
        ap++;
 54f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 553:	e9 b3 00 00 00       	jmp    60b <printf+0x193>
      } else if(c == 's'){
 558:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 55c:	75 45                	jne    5a3 <printf+0x12b>
        s = (char*)*ap;
 55e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 561:	8b 00                	mov    (%eax),%eax
 563:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 566:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 56a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 56e:	75 09                	jne    579 <printf+0x101>
          s = "(null)";
 570:	c7 45 f4 00 0b 00 00 	movl   $0xb00,-0xc(%ebp)
        while(*s != 0){
 577:	eb 1e                	jmp    597 <printf+0x11f>
 579:	eb 1c                	jmp    597 <printf+0x11f>
          putc(fd, *s);
 57b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57e:	0f b6 00             	movzbl (%eax),%eax
 581:	0f be c0             	movsbl %al,%eax
 584:	89 44 24 04          	mov    %eax,0x4(%esp)
 588:	8b 45 08             	mov    0x8(%ebp),%eax
 58b:	89 04 24             	mov    %eax,(%esp)
 58e:	e8 05 fe ff ff       	call   398 <putc>
          s++;
 593:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 597:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59a:	0f b6 00             	movzbl (%eax),%eax
 59d:	84 c0                	test   %al,%al
 59f:	75 da                	jne    57b <printf+0x103>
 5a1:	eb 68                	jmp    60b <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5a7:	75 1d                	jne    5c6 <printf+0x14e>
        putc(fd, *ap);
 5a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ac:	8b 00                	mov    (%eax),%eax
 5ae:	0f be c0             	movsbl %al,%eax
 5b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b5:	8b 45 08             	mov    0x8(%ebp),%eax
 5b8:	89 04 24             	mov    %eax,(%esp)
 5bb:	e8 d8 fd ff ff       	call   398 <putc>
        ap++;
 5c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c4:	eb 45                	jmp    60b <printf+0x193>
      } else if(c == '%'){
 5c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ca:	75 17                	jne    5e3 <printf+0x16b>
        putc(fd, c);
 5cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5cf:	0f be c0             	movsbl %al,%eax
 5d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d6:	8b 45 08             	mov    0x8(%ebp),%eax
 5d9:	89 04 24             	mov    %eax,(%esp)
 5dc:	e8 b7 fd ff ff       	call   398 <putc>
 5e1:	eb 28                	jmp    60b <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5ea:	00 
 5eb:	8b 45 08             	mov    0x8(%ebp),%eax
 5ee:	89 04 24             	mov    %eax,(%esp)
 5f1:	e8 a2 fd ff ff       	call   398 <putc>
        putc(fd, c);
 5f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f9:	0f be c0             	movsbl %al,%eax
 5fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 600:	8b 45 08             	mov    0x8(%ebp),%eax
 603:	89 04 24             	mov    %eax,(%esp)
 606:	e8 8d fd ff ff       	call   398 <putc>
      }
      state = 0;
 60b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 612:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 616:	8b 55 0c             	mov    0xc(%ebp),%edx
 619:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61c:	01 d0                	add    %edx,%eax
 61e:	0f b6 00             	movzbl (%eax),%eax
 621:	84 c0                	test   %al,%al
 623:	0f 85 71 fe ff ff    	jne    49a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 629:	c9                   	leave  
 62a:	c3                   	ret    
 62b:	90                   	nop

0000062c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 62c:	55                   	push   %ebp
 62d:	89 e5                	mov    %esp,%ebp
 62f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 632:	8b 45 08             	mov    0x8(%ebp),%eax
 635:	83 e8 08             	sub    $0x8,%eax
 638:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63b:	a1 18 0f 00 00       	mov    0xf18,%eax
 640:	89 45 fc             	mov    %eax,-0x4(%ebp)
 643:	eb 24                	jmp    669 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 645:	8b 45 fc             	mov    -0x4(%ebp),%eax
 648:	8b 00                	mov    (%eax),%eax
 64a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 64d:	77 12                	ja     661 <free+0x35>
 64f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 652:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 655:	77 24                	ja     67b <free+0x4f>
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 65f:	77 1a                	ja     67b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	8b 45 fc             	mov    -0x4(%ebp),%eax
 664:	8b 00                	mov    (%eax),%eax
 666:	89 45 fc             	mov    %eax,-0x4(%ebp)
 669:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66f:	76 d4                	jbe    645 <free+0x19>
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 679:	76 ca                	jbe    645 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	8b 40 04             	mov    0x4(%eax),%eax
 681:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 688:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68b:	01 c2                	add    %eax,%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	39 c2                	cmp    %eax,%edx
 694:	75 24                	jne    6ba <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	8b 50 04             	mov    0x4(%eax),%edx
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 00                	mov    (%eax),%eax
 6a1:	8b 40 04             	mov    0x4(%eax),%eax
 6a4:	01 c2                	add    %eax,%edx
 6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6af:	8b 00                	mov    (%eax),%eax
 6b1:	8b 10                	mov    (%eax),%edx
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	89 10                	mov    %edx,(%eax)
 6b8:	eb 0a                	jmp    6c4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 10                	mov    (%eax),%edx
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 40 04             	mov    0x4(%eax),%eax
 6ca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	01 d0                	add    %edx,%eax
 6d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d9:	75 20                	jne    6fb <free+0xcf>
    p->s.size += bp->s.size;
 6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6de:	8b 50 04             	mov    0x4(%eax),%edx
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	8b 40 04             	mov    0x4(%eax),%eax
 6e7:	01 c2                	add    %eax,%edx
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 10                	mov    (%eax),%edx
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	89 10                	mov    %edx,(%eax)
 6f9:	eb 08                	jmp    703 <free+0xd7>
  } else
    p->s.ptr = bp;
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 701:	89 10                	mov    %edx,(%eax)
  freep = p;
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	a3 18 0f 00 00       	mov    %eax,0xf18
}
 70b:	c9                   	leave  
 70c:	c3                   	ret    

0000070d <morecore>:

static Header*
morecore(uint nu)
{
 70d:	55                   	push   %ebp
 70e:	89 e5                	mov    %esp,%ebp
 710:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 713:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 71a:	77 07                	ja     723 <morecore+0x16>
    nu = 4096;
 71c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	c1 e0 03             	shl    $0x3,%eax
 729:	89 04 24             	mov    %eax,(%esp)
 72c:	e8 27 fc ff ff       	call   358 <sbrk>
 731:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 734:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 738:	75 07                	jne    741 <morecore+0x34>
    return 0;
 73a:	b8 00 00 00 00       	mov    $0x0,%eax
 73f:	eb 22                	jmp    763 <morecore+0x56>
  hp = (Header*)p;
 741:	8b 45 f4             	mov    -0xc(%ebp),%eax
 744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 747:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74a:	8b 55 08             	mov    0x8(%ebp),%edx
 74d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 750:	8b 45 f0             	mov    -0x10(%ebp),%eax
 753:	83 c0 08             	add    $0x8,%eax
 756:	89 04 24             	mov    %eax,(%esp)
 759:	e8 ce fe ff ff       	call   62c <free>
  return freep;
 75e:	a1 18 0f 00 00       	mov    0xf18,%eax
}
 763:	c9                   	leave  
 764:	c3                   	ret    

00000765 <malloc>:

void*
malloc(uint nbytes)
{
 765:	55                   	push   %ebp
 766:	89 e5                	mov    %esp,%ebp
 768:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 76b:	8b 45 08             	mov    0x8(%ebp),%eax
 76e:	83 c0 07             	add    $0x7,%eax
 771:	c1 e8 03             	shr    $0x3,%eax
 774:	83 c0 01             	add    $0x1,%eax
 777:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 77a:	a1 18 0f 00 00       	mov    0xf18,%eax
 77f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 782:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 786:	75 23                	jne    7ab <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 788:	c7 45 f0 10 0f 00 00 	movl   $0xf10,-0x10(%ebp)
 78f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 792:	a3 18 0f 00 00       	mov    %eax,0xf18
 797:	a1 18 0f 00 00       	mov    0xf18,%eax
 79c:	a3 10 0f 00 00       	mov    %eax,0xf10
    base.s.size = 0;
 7a1:	c7 05 14 0f 00 00 00 	movl   $0x0,0xf14
 7a8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ae:	8b 00                	mov    (%eax),%eax
 7b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	8b 40 04             	mov    0x4(%eax),%eax
 7b9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7bc:	72 4d                	jb     80b <malloc+0xa6>
      if(p->s.size == nunits)
 7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c1:	8b 40 04             	mov    0x4(%eax),%eax
 7c4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7c7:	75 0c                	jne    7d5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cc:	8b 10                	mov    (%eax),%edx
 7ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d1:	89 10                	mov    %edx,(%eax)
 7d3:	eb 26                	jmp    7fb <malloc+0x96>
      else {
        p->s.size -= nunits;
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7de:	89 c2                	mov    %eax,%edx
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 40 04             	mov    0x4(%eax),%eax
 7ec:	c1 e0 03             	shl    $0x3,%eax
 7ef:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7f8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fe:	a3 18 0f 00 00       	mov    %eax,0xf18
      return (void*)(p + 1);
 803:	8b 45 f4             	mov    -0xc(%ebp),%eax
 806:	83 c0 08             	add    $0x8,%eax
 809:	eb 38                	jmp    843 <malloc+0xde>
    }
    if(p == freep)
 80b:	a1 18 0f 00 00       	mov    0xf18,%eax
 810:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 813:	75 1b                	jne    830 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 815:	8b 45 ec             	mov    -0x14(%ebp),%eax
 818:	89 04 24             	mov    %eax,(%esp)
 81b:	e8 ed fe ff ff       	call   70d <morecore>
 820:	89 45 f4             	mov    %eax,-0xc(%ebp)
 823:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 827:	75 07                	jne    830 <malloc+0xcb>
        return 0;
 829:	b8 00 00 00 00       	mov    $0x0,%eax
 82e:	eb 13                	jmp    843 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	89 45 f0             	mov    %eax,-0x10(%ebp)
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	8b 00                	mov    (%eax),%eax
 83b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 83e:	e9 70 ff ff ff       	jmp    7b3 <malloc+0x4e>
}
 843:	c9                   	leave  
 844:	c3                   	ret    
 845:	66 90                	xchg   %ax,%ax
 847:	90                   	nop

00000848 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 848:	55                   	push   %ebp
 849:	89 e5                	mov    %esp,%ebp
 84b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 84e:	8b 55 08             	mov    0x8(%ebp),%edx
 851:	8b 45 0c             	mov    0xc(%ebp),%eax
 854:	8b 4d 08             	mov    0x8(%ebp),%ecx
 857:	f0 87 02             	lock xchg %eax,(%edx)
 85a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 860:	c9                   	leave  
 861:	c3                   	ret    

00000862 <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 862:	55                   	push   %ebp
 863:	89 e5                	mov    %esp,%ebp
 865:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 868:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 86f:	e8 f1 fe ff ff       	call   765 <malloc>
 874:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 877:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87a:	85 c0                	test   %eax,%eax
 87c:	75 1b                	jne    899 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 87e:	c7 44 24 04 08 0b 00 	movl   $0xb08,0x4(%esp)
 885:	00 
 886:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 88d:	e8 e6 fb ff ff       	call   478 <printf>
    return -1;
 892:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 897:	eb 43                	jmp    8dc <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 899:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89c:	25 ff 0f 00 00       	and    $0xfff,%eax
 8a1:	85 c0                	test   %eax,%eax
 8a3:	74 14                	je     8b9 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 8a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a8:	25 ff 0f 00 00       	and    $0xfff,%eax
 8ad:	89 c2                	mov    %eax,%edx
 8af:	b8 00 10 00 00       	mov    $0x1000,%eax
 8b4:	29 d0                	sub    %edx,%eax
 8b6:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 8c0:	8b 45 14             	mov    0x14(%ebp),%eax
 8c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 8c7:	8b 45 10             	mov    0x10(%ebp),%eax
 8ca:	89 04 24             	mov    %eax,(%esp)
 8cd:	e8 a6 fa ff ff       	call   378 <clone>
 8d2:	8b 55 08             	mov    0x8(%ebp),%edx
 8d5:	89 02                	mov    %eax,(%edx)
  return *thread;
 8d7:	8b 45 08             	mov    0x8(%ebp),%eax
 8da:	8b 00                	mov    (%eax),%eax
}
 8dc:	c9                   	leave  
 8dd:	c3                   	ret    

000008de <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 8de:	55                   	push   %ebp
 8df:	89 e5                	mov    %esp,%ebp
 8e1:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 8e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 8e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 8eb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ee:	89 04 24             	mov    %eax,(%esp)
 8f1:	e8 8a fa ff ff       	call   380 <join>
 8f6:	85 c0                	test   %eax,%eax
 8f8:	79 07                	jns    901 <pthread_join+0x23>
    return -1;
 8fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 8ff:	eb 10                	jmp    911 <pthread_join+0x33>
  }
  free(stack);
 901:	8b 45 f4             	mov    -0xc(%ebp),%eax
 904:	89 04 24             	mov    %eax,(%esp)
 907:	e8 20 fd ff ff       	call   62c <free>
  return 0;
 90c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 911:	c9                   	leave  
 912:	c3                   	ret    

00000913 <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 913:	55                   	push   %ebp
 914:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 916:	8b 45 08             	mov    0x8(%ebp),%eax
 919:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 91f:	90                   	nop
}
 920:	5d                   	pop    %ebp
 921:	c3                   	ret    

00000922 <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 922:	55                   	push   %ebp
 923:	89 e5                	mov    %esp,%ebp
 925:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 928:	90                   	nop
 929:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 930:	00 
 931:	8b 45 08             	mov    0x8(%ebp),%eax
 934:	89 04 24             	mov    %eax,(%esp)
 937:	e8 0c ff ff ff       	call   848 <xchg>
 93c:	85 c0                	test   %eax,%eax
 93e:	75 e9                	jne    929 <pthread_mutex_lock+0x7>
  return;
 940:	90                   	nop
}
 941:	c9                   	leave  
 942:	c3                   	ret    

00000943 <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 943:	55                   	push   %ebp
 944:	89 e5                	mov    %esp,%ebp
 946:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 949:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 950:	00 
 951:	8b 45 08             	mov    0x8(%ebp),%eax
 954:	89 04 24             	mov    %eax,(%esp)
 957:	e8 ec fe ff ff       	call   848 <xchg>
  return;
 95c:	90                   	nop
}
 95d:	c9                   	leave  
 95e:	c3                   	ret    

0000095f <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 95f:	55                   	push   %ebp
 960:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 962:	8b 45 08             	mov    0x8(%ebp),%eax
 965:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 96b:	8b 45 08             	mov    0x8(%ebp),%eax
 96e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 975:	90                   	nop
}
 976:	5d                   	pop    %ebp
 977:	c3                   	ret    

00000978 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 978:	55                   	push   %ebp
 979:	89 e5                	mov    %esp,%ebp
 97b:	53                   	push   %ebx
 97c:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 97f:	8b 45 08             	mov    0x8(%ebp),%eax
 982:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 985:	8b 45 0c             	mov    0xc(%ebp),%eax
 988:	89 04 24             	mov    %eax,(%esp)
 98b:	e8 b3 ff ff ff       	call   943 <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 990:	eb 09                	jmp    99b <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 992:	8b 45 f4             	mov    -0xc(%ebp),%eax
 995:	8b 40 04             	mov    0x4(%eax),%eax
 998:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 99b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99e:	8b 40 04             	mov    0x4(%eax),%eax
 9a1:	85 c0                	test   %eax,%eax
 9a3:	75 ed                	jne    992 <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 9a5:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 9ac:	e8 b4 fd ff ff       	call   765 <malloc>
 9b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9b4:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 9b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ba:	8b 58 04             	mov    0x4(%eax),%ebx
 9bd:	e8 8e f9 ff ff       	call   350 <getpid>
 9c2:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 9c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c7:	8b 40 04             	mov    0x4(%eax),%eax
 9ca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 9d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 9d4:	89 04 24             	mov    %eax,(%esp)
 9d7:	e8 46 ff ff ff       	call   922 <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 9dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 9df:	89 04 24             	mov    %eax,(%esp)
 9e2:	e8 5c ff ff ff       	call   943 <pthread_mutex_unlock>
  threadSleep(mutex);
 9e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 9ea:	89 04 24             	mov    %eax,(%esp)
 9ed:	e8 96 f9 ff ff       	call   388 <threadSleep>
  pthread_mutex_lock(mutex);
 9f2:	8b 45 0c             	mov    0xc(%ebp),%eax
 9f5:	89 04 24             	mov    %eax,(%esp)
 9f8:	e8 25 ff ff ff       	call   922 <pthread_mutex_lock>
  return;
 9fd:	90                   	nop
}
 9fe:	83 c4 24             	add    $0x24,%esp
 a01:	5b                   	pop    %ebx
 a02:	5d                   	pop    %ebp
 a03:	c3                   	ret    

00000a04 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 a04:	55                   	push   %ebp
 a05:	89 e5                	mov    %esp,%ebp
 a07:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 a0a:	8b 45 08             	mov    0x8(%ebp),%eax
 a0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 a10:	eb 09                	jmp    a1b <pthread_cond_signal+0x17>
    mycond = mycond->next;
 a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a15:	8b 40 04             	mov    0x4(%eax),%eax
 a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1e:	8b 00                	mov    (%eax),%eax
 a20:	83 f8 ff             	cmp    $0xffffffff,%eax
 a23:	74 ed                	je     a12 <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 a25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a29:	74 33                	je     a5e <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2e:	8b 00                	mov    (%eax),%eax
 a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 a39:	8b 45 08             	mov    0x8(%ebp),%eax
 a3c:	8b 40 04             	mov    0x4(%eax),%eax
 a3f:	8b 50 04             	mov    0x4(%eax),%edx
 a42:	8b 45 08             	mov    0x8(%ebp),%eax
 a45:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 a48:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a4b:	89 04 24             	mov    %eax,(%esp)
 a4e:	e8 d9 fb ff ff       	call   62c <free>
    threadWake(threadId);
 a53:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a56:	89 04 24             	mov    %eax,(%esp)
 a59:	e8 32 f9 ff ff       	call   390 <threadWake>
  }
  return;
 a5e:	90                   	nop
}
 a5f:	c9                   	leave  
 a60:	c3                   	ret    

00000a61 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 a61:	55                   	push   %ebp
 a62:	89 e5                	mov    %esp,%ebp
 a64:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 a67:	8b 45 08             	mov    0x8(%ebp),%eax
 a6a:	8b 55 10             	mov    0x10(%ebp),%edx
 a6d:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 a6f:	8b 45 08             	mov    0x8(%ebp),%eax
 a72:	83 c0 04             	add    $0x4,%eax
 a75:	89 04 24             	mov    %eax,(%esp)
 a78:	e8 e2 fe ff ff       	call   95f <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 a7d:	8b 45 08             	mov    0x8(%ebp),%eax
 a80:	83 c0 0c             	add    $0xc,%eax
 a83:	89 04 24             	mov    %eax,(%esp)
 a86:	e8 88 fe ff ff       	call   913 <pthread_mutex_init>
  return;
 a8b:	90                   	nop
}
 a8c:	c9                   	leave  
 a8d:	c3                   	ret    

00000a8e <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 a8e:	55                   	push   %ebp
 a8f:	89 e5                	mov    %esp,%ebp
 a91:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 a94:	8b 45 08             	mov    0x8(%ebp),%eax
 a97:	8b 00                	mov    (%eax),%eax
 a99:	8d 50 ff             	lea    -0x1(%eax),%edx
 a9c:	8b 45 08             	mov    0x8(%ebp),%eax
 a9f:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 aa1:	8b 45 08             	mov    0x8(%ebp),%eax
 aa4:	8b 00                	mov    (%eax),%eax
 aa6:	85 c0                	test   %eax,%eax
 aa8:	79 18                	jns    ac2 <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 aaa:	8b 45 08             	mov    0x8(%ebp),%eax
 aad:	8d 50 0c             	lea    0xc(%eax),%edx
 ab0:	8b 45 08             	mov    0x8(%ebp),%eax
 ab3:	83 c0 04             	add    $0x4,%eax
 ab6:	89 54 24 04          	mov    %edx,0x4(%esp)
 aba:	89 04 24             	mov    %eax,(%esp)
 abd:	e8 b6 fe ff ff       	call   978 <pthread_cond_wait>
  }
  return;
 ac2:	90                   	nop
}
 ac3:	c9                   	leave  
 ac4:	c3                   	ret    

00000ac5 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 ac5:	55                   	push   %ebp
 ac6:	89 e5                	mov    %esp,%ebp
 ac8:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 acb:	8b 45 08             	mov    0x8(%ebp),%eax
 ace:	8b 00                	mov    (%eax),%eax
 ad0:	8d 50 01             	lea    0x1(%eax),%edx
 ad3:	8b 45 08             	mov    0x8(%ebp),%eax
 ad6:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 ad8:	8b 45 08             	mov    0x8(%ebp),%eax
 adb:	83 c0 04             	add    $0x4,%eax
 ade:	89 04 24             	mov    %eax,(%esp)
 ae1:	e8 1e ff ff ff       	call   a04 <pthread_cond_signal>
  return;
 ae6:	90                   	nop
}
 ae7:	c9                   	leave  
 ae8:	c3                   	ret    
