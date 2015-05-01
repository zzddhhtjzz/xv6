
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 76 02 00 00       	call   284 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 fe 02 00 00       	call   31c <sleep>
  exit();
  1e:	e8 69 02 00 00       	call   28c <exit>
  23:	90                   	nop

00000024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	57                   	push   %edi
  28:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2c:	8b 55 10             	mov    0x10(%ebp),%edx
  2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  32:	89 cb                	mov    %ecx,%ebx
  34:	89 df                	mov    %ebx,%edi
  36:	89 d1                	mov    %edx,%ecx
  38:	fc                   	cld    
  39:	f3 aa                	rep stos %al,%es:(%edi)
  3b:	89 ca                	mov    %ecx,%edx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  42:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  45:	5b                   	pop    %ebx
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4f:	8b 45 08             	mov    0x8(%ebp),%eax
  52:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  55:	90                   	nop
  56:	8b 45 08             	mov    0x8(%ebp),%eax
  59:	8d 50 01             	lea    0x1(%eax),%edx
  5c:	89 55 08             	mov    %edx,0x8(%ebp)
  5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  62:	8d 4a 01             	lea    0x1(%edx),%ecx
  65:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  68:	0f b6 12             	movzbl (%edx),%edx
  6b:	88 10                	mov    %dl,(%eax)
  6d:	0f b6 00             	movzbl (%eax),%eax
  70:	84 c0                	test   %al,%al
  72:	75 e2                	jne    56 <strcpy+0xd>
    ;
  return os;
  74:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  77:	c9                   	leave  
  78:	c3                   	ret    

00000079 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  79:	55                   	push   %ebp
  7a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  7c:	eb 08                	jmp    86 <strcmp+0xd>
    p++, q++;
  7e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  82:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  86:	8b 45 08             	mov    0x8(%ebp),%eax
  89:	0f b6 00             	movzbl (%eax),%eax
  8c:	84 c0                	test   %al,%al
  8e:	74 10                	je     a0 <strcmp+0x27>
  90:	8b 45 08             	mov    0x8(%ebp),%eax
  93:	0f b6 10             	movzbl (%eax),%edx
  96:	8b 45 0c             	mov    0xc(%ebp),%eax
  99:	0f b6 00             	movzbl (%eax),%eax
  9c:	38 c2                	cmp    %al,%dl
  9e:	74 de                	je     7e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	0f b6 00             	movzbl (%eax),%eax
  a6:	0f b6 d0             	movzbl %al,%edx
  a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  ac:	0f b6 00             	movzbl (%eax),%eax
  af:	0f b6 c0             	movzbl %al,%eax
  b2:	29 c2                	sub    %eax,%edx
  b4:	89 d0                	mov    %edx,%eax
}
  b6:	5d                   	pop    %ebp
  b7:	c3                   	ret    

000000b8 <strlen>:

uint
strlen(char *s)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c5:	eb 04                	jmp    cb <strlen+0x13>
  c7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  ce:	8b 45 08             	mov    0x8(%ebp),%eax
  d1:	01 d0                	add    %edx,%eax
  d3:	0f b6 00             	movzbl (%eax),%eax
  d6:	84 c0                	test   %al,%al
  d8:	75 ed                	jne    c7 <strlen+0xf>
    ;
  return n;
  da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  dd:	c9                   	leave  
  de:	c3                   	ret    

000000df <memset>:

void*
memset(void *dst, int c, uint n)
{
  df:	55                   	push   %ebp
  e0:	89 e5                	mov    %esp,%ebp
  e2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  e5:	8b 45 10             	mov    0x10(%ebp),%eax
  e8:	89 44 24 08          	mov    %eax,0x8(%esp)
  ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	89 04 24             	mov    %eax,(%esp)
  f9:	e8 26 ff ff ff       	call   24 <stosb>
  return dst;
  fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
 101:	c9                   	leave  
 102:	c3                   	ret    

00000103 <strchr>:

char*
strchr(const char *s, char c)
{
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	83 ec 04             	sub    $0x4,%esp
 109:	8b 45 0c             	mov    0xc(%ebp),%eax
 10c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10f:	eb 14                	jmp    125 <strchr+0x22>
    if(*s == c)
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	0f b6 00             	movzbl (%eax),%eax
 117:	3a 45 fc             	cmp    -0x4(%ebp),%al
 11a:	75 05                	jne    121 <strchr+0x1e>
      return (char*)s;
 11c:	8b 45 08             	mov    0x8(%ebp),%eax
 11f:	eb 13                	jmp    134 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 121:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	0f b6 00             	movzbl (%eax),%eax
 12b:	84 c0                	test   %al,%al
 12d:	75 e2                	jne    111 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 12f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 134:	c9                   	leave  
 135:	c3                   	ret    

00000136 <gets>:

char*
gets(char *buf, int max)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
 139:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 143:	eb 4c                	jmp    191 <gets+0x5b>
    cc = read(0, &c, 1);
 145:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 14c:	00 
 14d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 150:	89 44 24 04          	mov    %eax,0x4(%esp)
 154:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15b:	e8 44 01 00 00       	call   2a4 <read>
 160:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 163:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 167:	7f 02                	jg     16b <gets+0x35>
      break;
 169:	eb 31                	jmp    19c <gets+0x66>
    buf[i++] = c;
 16b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16e:	8d 50 01             	lea    0x1(%eax),%edx
 171:	89 55 f4             	mov    %edx,-0xc(%ebp)
 174:	89 c2                	mov    %eax,%edx
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	01 c2                	add    %eax,%edx
 17b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 181:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 185:	3c 0a                	cmp    $0xa,%al
 187:	74 13                	je     19c <gets+0x66>
 189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18d:	3c 0d                	cmp    $0xd,%al
 18f:	74 0b                	je     19c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 191:	8b 45 f4             	mov    -0xc(%ebp),%eax
 194:	83 c0 01             	add    $0x1,%eax
 197:	3b 45 0c             	cmp    0xc(%ebp),%eax
 19a:	7c a9                	jl     145 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	01 d0                	add    %edx,%eax
 1a4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1aa:	c9                   	leave  
 1ab:	c3                   	ret    

000001ac <stat>:

int
stat(char *n, struct stat *st)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b9:	00 
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	89 04 24             	mov    %eax,(%esp)
 1c0:	e8 07 01 00 00       	call   2cc <open>
 1c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1cc:	79 07                	jns    1d5 <stat+0x29>
    return -1;
 1ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d3:	eb 23                	jmp    1f8 <stat+0x4c>
  r = fstat(fd, st);
 1d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1df:	89 04 24             	mov    %eax,(%esp)
 1e2:	e8 fd 00 00 00       	call   2e4 <fstat>
 1e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ed:	89 04 24             	mov    %eax,(%esp)
 1f0:	e8 bf 00 00 00       	call   2b4 <close>
  return r;
 1f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f8:	c9                   	leave  
 1f9:	c3                   	ret    

000001fa <atoi>:

int
atoi(const char *s)
{
 1fa:	55                   	push   %ebp
 1fb:	89 e5                	mov    %esp,%ebp
 1fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 200:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 207:	eb 25                	jmp    22e <atoi+0x34>
    n = n*10 + *s++ - '0';
 209:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20c:	89 d0                	mov    %edx,%eax
 20e:	c1 e0 02             	shl    $0x2,%eax
 211:	01 d0                	add    %edx,%eax
 213:	01 c0                	add    %eax,%eax
 215:	89 c1                	mov    %eax,%ecx
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	8d 50 01             	lea    0x1(%eax),%edx
 21d:	89 55 08             	mov    %edx,0x8(%ebp)
 220:	0f b6 00             	movzbl (%eax),%eax
 223:	0f be c0             	movsbl %al,%eax
 226:	01 c8                	add    %ecx,%eax
 228:	83 e8 30             	sub    $0x30,%eax
 22b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22e:	8b 45 08             	mov    0x8(%ebp),%eax
 231:	0f b6 00             	movzbl (%eax),%eax
 234:	3c 2f                	cmp    $0x2f,%al
 236:	7e 0a                	jle    242 <atoi+0x48>
 238:	8b 45 08             	mov    0x8(%ebp),%eax
 23b:	0f b6 00             	movzbl (%eax),%eax
 23e:	3c 39                	cmp    $0x39,%al
 240:	7e c7                	jle    209 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 242:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 245:	c9                   	leave  
 246:	c3                   	ret    

00000247 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 247:	55                   	push   %ebp
 248:	89 e5                	mov    %esp,%ebp
 24a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
 250:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 253:	8b 45 0c             	mov    0xc(%ebp),%eax
 256:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 259:	eb 17                	jmp    272 <memmove+0x2b>
    *dst++ = *src++;
 25b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25e:	8d 50 01             	lea    0x1(%eax),%edx
 261:	89 55 fc             	mov    %edx,-0x4(%ebp)
 264:	8b 55 f8             	mov    -0x8(%ebp),%edx
 267:	8d 4a 01             	lea    0x1(%edx),%ecx
 26a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 26d:	0f b6 12             	movzbl (%edx),%edx
 270:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	8b 45 10             	mov    0x10(%ebp),%eax
 275:	8d 50 ff             	lea    -0x1(%eax),%edx
 278:	89 55 10             	mov    %edx,0x10(%ebp)
 27b:	85 c0                	test   %eax,%eax
 27d:	7f dc                	jg     25b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 284:	b8 01 00 00 00       	mov    $0x1,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <exit>:
SYSCALL(exit)
 28c:	b8 02 00 00 00       	mov    $0x2,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <wait>:
SYSCALL(wait)
 294:	b8 03 00 00 00       	mov    $0x3,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <pipe>:
SYSCALL(pipe)
 29c:	b8 04 00 00 00       	mov    $0x4,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <read>:
SYSCALL(read)
 2a4:	b8 05 00 00 00       	mov    $0x5,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <write>:
SYSCALL(write)
 2ac:	b8 10 00 00 00       	mov    $0x10,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <close>:
SYSCALL(close)
 2b4:	b8 15 00 00 00       	mov    $0x15,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <kill>:
SYSCALL(kill)
 2bc:	b8 06 00 00 00       	mov    $0x6,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <exec>:
SYSCALL(exec)
 2c4:	b8 07 00 00 00       	mov    $0x7,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <open>:
SYSCALL(open)
 2cc:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <mknod>:
SYSCALL(mknod)
 2d4:	b8 11 00 00 00       	mov    $0x11,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <unlink>:
SYSCALL(unlink)
 2dc:	b8 12 00 00 00       	mov    $0x12,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <fstat>:
SYSCALL(fstat)
 2e4:	b8 08 00 00 00       	mov    $0x8,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <link>:
SYSCALL(link)
 2ec:	b8 13 00 00 00       	mov    $0x13,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <mkdir>:
SYSCALL(mkdir)
 2f4:	b8 14 00 00 00       	mov    $0x14,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <chdir>:
SYSCALL(chdir)
 2fc:	b8 09 00 00 00       	mov    $0x9,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <dup>:
SYSCALL(dup)
 304:	b8 0a 00 00 00       	mov    $0xa,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <getpid>:
SYSCALL(getpid)
 30c:	b8 0b 00 00 00       	mov    $0xb,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <sbrk>:
SYSCALL(sbrk)
 314:	b8 0c 00 00 00       	mov    $0xc,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <sleep>:
SYSCALL(sleep)
 31c:	b8 0d 00 00 00       	mov    $0xd,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <uptime>:
SYSCALL(uptime)
 324:	b8 0e 00 00 00       	mov    $0xe,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <date>:
SYSCALL(date)
 32c:	b8 16 00 00 00       	mov    $0x16,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <clone>:
SYSCALL(clone)
 334:	b8 17 00 00 00       	mov    $0x17,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <join>:
SYSCALL(join)
 33c:	b8 18 00 00 00       	mov    $0x18,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <threadSleep>:
SYSCALL(threadSleep)
 344:	b8 19 00 00 00       	mov    $0x19,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <threadWake>:
SYSCALL(threadWake)
 34c:	b8 1a 00 00 00       	mov    $0x1a,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	83 ec 18             	sub    $0x18,%esp
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 360:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 367:	00 
 368:	8d 45 f4             	lea    -0xc(%ebp),%eax
 36b:	89 44 24 04          	mov    %eax,0x4(%esp)
 36f:	8b 45 08             	mov    0x8(%ebp),%eax
 372:	89 04 24             	mov    %eax,(%esp)
 375:	e8 32 ff ff ff       	call   2ac <write>
}
 37a:	c9                   	leave  
 37b:	c3                   	ret    

0000037c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 37c:	55                   	push   %ebp
 37d:	89 e5                	mov    %esp,%ebp
 37f:	56                   	push   %esi
 380:	53                   	push   %ebx
 381:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 384:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 38b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 38f:	74 17                	je     3a8 <printint+0x2c>
 391:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 395:	79 11                	jns    3a8 <printint+0x2c>
    neg = 1;
 397:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	f7 d8                	neg    %eax
 3a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3a6:	eb 06                	jmp    3ae <printint+0x32>
  } else {
    x = xx;
 3a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3b8:	8d 41 01             	lea    0x1(%ecx),%eax
 3bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3be:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c4:	ba 00 00 00 00       	mov    $0x0,%edx
 3c9:	f7 f3                	div    %ebx
 3cb:	89 d0                	mov    %edx,%eax
 3cd:	0f b6 80 a4 0e 00 00 	movzbl 0xea4(%eax),%eax
 3d4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3d8:	8b 75 10             	mov    0x10(%ebp),%esi
 3db:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3de:	ba 00 00 00 00       	mov    $0x0,%edx
 3e3:	f7 f6                	div    %esi
 3e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ec:	75 c7                	jne    3b5 <printint+0x39>
  if(neg)
 3ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f2:	74 10                	je     404 <printint+0x88>
    buf[i++] = '-';
 3f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f7:	8d 50 01             	lea    0x1(%eax),%edx
 3fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 402:	eb 1f                	jmp    423 <printint+0xa7>
 404:	eb 1d                	jmp    423 <printint+0xa7>
    putc(fd, buf[i]);
 406:	8d 55 dc             	lea    -0x24(%ebp),%edx
 409:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40c:	01 d0                	add    %edx,%eax
 40e:	0f b6 00             	movzbl (%eax),%eax
 411:	0f be c0             	movsbl %al,%eax
 414:	89 44 24 04          	mov    %eax,0x4(%esp)
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	89 04 24             	mov    %eax,(%esp)
 41e:	e8 31 ff ff ff       	call   354 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 423:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 427:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 42b:	79 d9                	jns    406 <printint+0x8a>
    putc(fd, buf[i]);
}
 42d:	83 c4 30             	add    $0x30,%esp
 430:	5b                   	pop    %ebx
 431:	5e                   	pop    %esi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    

00000434 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 43a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 441:	8d 45 0c             	lea    0xc(%ebp),%eax
 444:	83 c0 04             	add    $0x4,%eax
 447:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 44a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 451:	e9 7c 01 00 00       	jmp    5d2 <printf+0x19e>
    c = fmt[i] & 0xff;
 456:	8b 55 0c             	mov    0xc(%ebp),%edx
 459:	8b 45 f0             	mov    -0x10(%ebp),%eax
 45c:	01 d0                	add    %edx,%eax
 45e:	0f b6 00             	movzbl (%eax),%eax
 461:	0f be c0             	movsbl %al,%eax
 464:	25 ff 00 00 00       	and    $0xff,%eax
 469:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 46c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 470:	75 2c                	jne    49e <printf+0x6a>
      if(c == '%'){
 472:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 476:	75 0c                	jne    484 <printf+0x50>
        state = '%';
 478:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 47f:	e9 4a 01 00 00       	jmp    5ce <printf+0x19a>
      } else {
        putc(fd, c);
 484:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 487:	0f be c0             	movsbl %al,%eax
 48a:	89 44 24 04          	mov    %eax,0x4(%esp)
 48e:	8b 45 08             	mov    0x8(%ebp),%eax
 491:	89 04 24             	mov    %eax,(%esp)
 494:	e8 bb fe ff ff       	call   354 <putc>
 499:	e9 30 01 00 00       	jmp    5ce <printf+0x19a>
      }
    } else if(state == '%'){
 49e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4a2:	0f 85 26 01 00 00    	jne    5ce <printf+0x19a>
      if(c == 'd'){
 4a8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ac:	75 2d                	jne    4db <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b1:	8b 00                	mov    (%eax),%eax
 4b3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4ba:	00 
 4bb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4c2:	00 
 4c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ca:	89 04 24             	mov    %eax,(%esp)
 4cd:	e8 aa fe ff ff       	call   37c <printint>
        ap++;
 4d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d6:	e9 ec 00 00 00       	jmp    5c7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 4db:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4df:	74 06                	je     4e7 <printf+0xb3>
 4e1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e5:	75 2d                	jne    514 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ea:	8b 00                	mov    (%eax),%eax
 4ec:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4f3:	00 
 4f4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4fb:	00 
 4fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 500:	8b 45 08             	mov    0x8(%ebp),%eax
 503:	89 04 24             	mov    %eax,(%esp)
 506:	e8 71 fe ff ff       	call   37c <printint>
        ap++;
 50b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50f:	e9 b3 00 00 00       	jmp    5c7 <printf+0x193>
      } else if(c == 's'){
 514:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 518:	75 45                	jne    55f <printf+0x12b>
        s = (char*)*ap;
 51a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51d:	8b 00                	mov    (%eax),%eax
 51f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 522:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 526:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 52a:	75 09                	jne    535 <printf+0x101>
          s = "(null)";
 52c:	c7 45 f4 a8 0a 00 00 	movl   $0xaa8,-0xc(%ebp)
        while(*s != 0){
 533:	eb 1e                	jmp    553 <printf+0x11f>
 535:	eb 1c                	jmp    553 <printf+0x11f>
          putc(fd, *s);
 537:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53a:	0f b6 00             	movzbl (%eax),%eax
 53d:	0f be c0             	movsbl %al,%eax
 540:	89 44 24 04          	mov    %eax,0x4(%esp)
 544:	8b 45 08             	mov    0x8(%ebp),%eax
 547:	89 04 24             	mov    %eax,(%esp)
 54a:	e8 05 fe ff ff       	call   354 <putc>
          s++;
 54f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 553:	8b 45 f4             	mov    -0xc(%ebp),%eax
 556:	0f b6 00             	movzbl (%eax),%eax
 559:	84 c0                	test   %al,%al
 55b:	75 da                	jne    537 <printf+0x103>
 55d:	eb 68                	jmp    5c7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 55f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 563:	75 1d                	jne    582 <printf+0x14e>
        putc(fd, *ap);
 565:	8b 45 e8             	mov    -0x18(%ebp),%eax
 568:	8b 00                	mov    (%eax),%eax
 56a:	0f be c0             	movsbl %al,%eax
 56d:	89 44 24 04          	mov    %eax,0x4(%esp)
 571:	8b 45 08             	mov    0x8(%ebp),%eax
 574:	89 04 24             	mov    %eax,(%esp)
 577:	e8 d8 fd ff ff       	call   354 <putc>
        ap++;
 57c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 580:	eb 45                	jmp    5c7 <printf+0x193>
      } else if(c == '%'){
 582:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 586:	75 17                	jne    59f <printf+0x16b>
        putc(fd, c);
 588:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58b:	0f be c0             	movsbl %al,%eax
 58e:	89 44 24 04          	mov    %eax,0x4(%esp)
 592:	8b 45 08             	mov    0x8(%ebp),%eax
 595:	89 04 24             	mov    %eax,(%esp)
 598:	e8 b7 fd ff ff       	call   354 <putc>
 59d:	eb 28                	jmp    5c7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 59f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5a6:	00 
 5a7:	8b 45 08             	mov    0x8(%ebp),%eax
 5aa:	89 04 24             	mov    %eax,(%esp)
 5ad:	e8 a2 fd ff ff       	call   354 <putc>
        putc(fd, c);
 5b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b5:	0f be c0             	movsbl %al,%eax
 5b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bc:	8b 45 08             	mov    0x8(%ebp),%eax
 5bf:	89 04 24             	mov    %eax,(%esp)
 5c2:	e8 8d fd ff ff       	call   354 <putc>
      }
      state = 0;
 5c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ce:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5d2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d8:	01 d0                	add    %edx,%eax
 5da:	0f b6 00             	movzbl (%eax),%eax
 5dd:	84 c0                	test   %al,%al
 5df:	0f 85 71 fe ff ff    	jne    456 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5e5:	c9                   	leave  
 5e6:	c3                   	ret    
 5e7:	90                   	nop

000005e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e8:	55                   	push   %ebp
 5e9:	89 e5                	mov    %esp,%ebp
 5eb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5ee:	8b 45 08             	mov    0x8(%ebp),%eax
 5f1:	83 e8 08             	sub    $0x8,%eax
 5f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f7:	a1 c0 0e 00 00       	mov    0xec0,%eax
 5fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ff:	eb 24                	jmp    625 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 601:	8b 45 fc             	mov    -0x4(%ebp),%eax
 604:	8b 00                	mov    (%eax),%eax
 606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 609:	77 12                	ja     61d <free+0x35>
 60b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 611:	77 24                	ja     637 <free+0x4f>
 613:	8b 45 fc             	mov    -0x4(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 61b:	77 1a                	ja     637 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	89 45 fc             	mov    %eax,-0x4(%ebp)
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 62b:	76 d4                	jbe    601 <free+0x19>
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 00                	mov    (%eax),%eax
 632:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 635:	76 ca                	jbe    601 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	8b 40 04             	mov    0x4(%eax),%eax
 63d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 644:	8b 45 f8             	mov    -0x8(%ebp),%eax
 647:	01 c2                	add    %eax,%edx
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	39 c2                	cmp    %eax,%edx
 650:	75 24                	jne    676 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	8b 50 04             	mov    0x4(%eax),%edx
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	8b 40 04             	mov    0x4(%eax),%eax
 660:	01 c2                	add    %eax,%edx
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	8b 10                	mov    (%eax),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	89 10                	mov    %edx,(%eax)
 674:	eb 0a                	jmp    680 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	8b 10                	mov    (%eax),%edx
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 680:	8b 45 fc             	mov    -0x4(%ebp),%eax
 683:	8b 40 04             	mov    0x4(%eax),%eax
 686:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	01 d0                	add    %edx,%eax
 692:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 695:	75 20                	jne    6b7 <free+0xcf>
    p->s.size += bp->s.size;
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 50 04             	mov    0x4(%eax),%edx
 69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a0:	8b 40 04             	mov    0x4(%eax),%eax
 6a3:	01 c2                	add    %eax,%edx
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	8b 10                	mov    (%eax),%edx
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	89 10                	mov    %edx,(%eax)
 6b5:	eb 08                	jmp    6bf <free+0xd7>
  } else
    p->s.ptr = bp;
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6bd:	89 10                	mov    %edx,(%eax)
  freep = p;
 6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c2:	a3 c0 0e 00 00       	mov    %eax,0xec0
}
 6c7:	c9                   	leave  
 6c8:	c3                   	ret    

000006c9 <morecore>:

static Header*
morecore(uint nu)
{
 6c9:	55                   	push   %ebp
 6ca:	89 e5                	mov    %esp,%ebp
 6cc:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6cf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6d6:	77 07                	ja     6df <morecore+0x16>
    nu = 4096;
 6d8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6df:	8b 45 08             	mov    0x8(%ebp),%eax
 6e2:	c1 e0 03             	shl    $0x3,%eax
 6e5:	89 04 24             	mov    %eax,(%esp)
 6e8:	e8 27 fc ff ff       	call   314 <sbrk>
 6ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6f0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6f4:	75 07                	jne    6fd <morecore+0x34>
    return 0;
 6f6:	b8 00 00 00 00       	mov    $0x0,%eax
 6fb:	eb 22                	jmp    71f <morecore+0x56>
  hp = (Header*)p;
 6fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 700:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 703:	8b 45 f0             	mov    -0x10(%ebp),%eax
 706:	8b 55 08             	mov    0x8(%ebp),%edx
 709:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 70c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70f:	83 c0 08             	add    $0x8,%eax
 712:	89 04 24             	mov    %eax,(%esp)
 715:	e8 ce fe ff ff       	call   5e8 <free>
  return freep;
 71a:	a1 c0 0e 00 00       	mov    0xec0,%eax
}
 71f:	c9                   	leave  
 720:	c3                   	ret    

00000721 <malloc>:

void*
malloc(uint nbytes)
{
 721:	55                   	push   %ebp
 722:	89 e5                	mov    %esp,%ebp
 724:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 727:	8b 45 08             	mov    0x8(%ebp),%eax
 72a:	83 c0 07             	add    $0x7,%eax
 72d:	c1 e8 03             	shr    $0x3,%eax
 730:	83 c0 01             	add    $0x1,%eax
 733:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 736:	a1 c0 0e 00 00       	mov    0xec0,%eax
 73b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 73e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 742:	75 23                	jne    767 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 744:	c7 45 f0 b8 0e 00 00 	movl   $0xeb8,-0x10(%ebp)
 74b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74e:	a3 c0 0e 00 00       	mov    %eax,0xec0
 753:	a1 c0 0e 00 00       	mov    0xec0,%eax
 758:	a3 b8 0e 00 00       	mov    %eax,0xeb8
    base.s.size = 0;
 75d:	c7 05 bc 0e 00 00 00 	movl   $0x0,0xebc
 764:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	8b 40 04             	mov    0x4(%eax),%eax
 775:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 778:	72 4d                	jb     7c7 <malloc+0xa6>
      if(p->s.size == nunits)
 77a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77d:	8b 40 04             	mov    0x4(%eax),%eax
 780:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 783:	75 0c                	jne    791 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 785:	8b 45 f4             	mov    -0xc(%ebp),%eax
 788:	8b 10                	mov    (%eax),%edx
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	89 10                	mov    %edx,(%eax)
 78f:	eb 26                	jmp    7b7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 791:	8b 45 f4             	mov    -0xc(%ebp),%eax
 794:	8b 40 04             	mov    0x4(%eax),%eax
 797:	2b 45 ec             	sub    -0x14(%ebp),%eax
 79a:	89 c2                	mov    %eax,%edx
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	8b 40 04             	mov    0x4(%eax),%eax
 7a8:	c1 e0 03             	shl    $0x3,%eax
 7ab:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7b4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ba:	a3 c0 0e 00 00       	mov    %eax,0xec0
      return (void*)(p + 1);
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	83 c0 08             	add    $0x8,%eax
 7c5:	eb 38                	jmp    7ff <malloc+0xde>
    }
    if(p == freep)
 7c7:	a1 c0 0e 00 00       	mov    0xec0,%eax
 7cc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7cf:	75 1b                	jne    7ec <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7d4:	89 04 24             	mov    %eax,(%esp)
 7d7:	e8 ed fe ff ff       	call   6c9 <morecore>
 7dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e3:	75 07                	jne    7ec <malloc+0xcb>
        return 0;
 7e5:	b8 00 00 00 00       	mov    $0x0,%eax
 7ea:	eb 13                	jmp    7ff <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f5:	8b 00                	mov    (%eax),%eax
 7f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7fa:	e9 70 ff ff ff       	jmp    76f <malloc+0x4e>
}
 7ff:	c9                   	leave  
 800:	c3                   	ret    
 801:	66 90                	xchg   %ax,%ax
 803:	90                   	nop

00000804 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 804:	55                   	push   %ebp
 805:	89 e5                	mov    %esp,%ebp
 807:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 80a:	8b 55 08             	mov    0x8(%ebp),%edx
 80d:	8b 45 0c             	mov    0xc(%ebp),%eax
 810:	8b 4d 08             	mov    0x8(%ebp),%ecx
 813:	f0 87 02             	lock xchg %eax,(%edx)
 816:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 81c:	c9                   	leave  
 81d:	c3                   	ret    

0000081e <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 81e:	55                   	push   %ebp
 81f:	89 e5                	mov    %esp,%ebp
 821:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 824:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 82b:	e8 f1 fe ff ff       	call   721 <malloc>
 830:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	85 c0                	test   %eax,%eax
 838:	75 1b                	jne    855 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 83a:	c7 44 24 04 b0 0a 00 	movl   $0xab0,0x4(%esp)
 841:	00 
 842:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 849:	e8 e6 fb ff ff       	call   434 <printf>
    return -1;
 84e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 853:	eb 43                	jmp    898 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	25 ff 0f 00 00       	and    $0xfff,%eax
 85d:	85 c0                	test   %eax,%eax
 85f:	74 14                	je     875 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 861:	8b 45 f4             	mov    -0xc(%ebp),%eax
 864:	25 ff 0f 00 00       	and    $0xfff,%eax
 869:	89 c2                	mov    %eax,%edx
 86b:	b8 00 10 00 00       	mov    $0x1000,%eax
 870:	29 d0                	sub    %edx,%eax
 872:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 875:	8b 45 f4             	mov    -0xc(%ebp),%eax
 878:	89 44 24 08          	mov    %eax,0x8(%esp)
 87c:	8b 45 14             	mov    0x14(%ebp),%eax
 87f:	89 44 24 04          	mov    %eax,0x4(%esp)
 883:	8b 45 10             	mov    0x10(%ebp),%eax
 886:	89 04 24             	mov    %eax,(%esp)
 889:	e8 a6 fa ff ff       	call   334 <clone>
 88e:	8b 55 08             	mov    0x8(%ebp),%edx
 891:	89 02                	mov    %eax,(%edx)
  return *thread;
 893:	8b 45 08             	mov    0x8(%ebp),%eax
 896:	8b 00                	mov    (%eax),%eax
}
 898:	c9                   	leave  
 899:	c3                   	ret    

0000089a <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 89a:	55                   	push   %ebp
 89b:	89 e5                	mov    %esp,%ebp
 89d:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 8a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 8a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a7:	8b 45 08             	mov    0x8(%ebp),%eax
 8aa:	89 04 24             	mov    %eax,(%esp)
 8ad:	e8 8a fa ff ff       	call   33c <join>
 8b2:	85 c0                	test   %eax,%eax
 8b4:	79 07                	jns    8bd <pthread_join+0x23>
    return -1;
 8b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 8bb:	eb 10                	jmp    8cd <pthread_join+0x33>
  }
  free(stack);
 8bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c0:	89 04 24             	mov    %eax,(%esp)
 8c3:	e8 20 fd ff ff       	call   5e8 <free>
  return 0;
 8c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 8cd:	c9                   	leave  
 8ce:	c3                   	ret    

000008cf <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 8cf:	55                   	push   %ebp
 8d0:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 8d2:	8b 45 08             	mov    0x8(%ebp),%eax
 8d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 8db:	90                   	nop
}
 8dc:	5d                   	pop    %ebp
 8dd:	c3                   	ret    

000008de <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 8de:	55                   	push   %ebp
 8df:	89 e5                	mov    %esp,%ebp
 8e1:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 8e4:	90                   	nop
 8e5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 8ec:	00 
 8ed:	8b 45 08             	mov    0x8(%ebp),%eax
 8f0:	89 04 24             	mov    %eax,(%esp)
 8f3:	e8 0c ff ff ff       	call   804 <xchg>
 8f8:	85 c0                	test   %eax,%eax
 8fa:	75 e9                	jne    8e5 <pthread_mutex_lock+0x7>
  return;
 8fc:	90                   	nop
}
 8fd:	c9                   	leave  
 8fe:	c3                   	ret    

000008ff <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 8ff:	55                   	push   %ebp
 900:	89 e5                	mov    %esp,%ebp
 902:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 905:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 90c:	00 
 90d:	8b 45 08             	mov    0x8(%ebp),%eax
 910:	89 04 24             	mov    %eax,(%esp)
 913:	e8 ec fe ff ff       	call   804 <xchg>
  return;
 918:	90                   	nop
}
 919:	c9                   	leave  
 91a:	c3                   	ret    

0000091b <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 91b:	55                   	push   %ebp
 91c:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 91e:	8b 45 08             	mov    0x8(%ebp),%eax
 921:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 927:	8b 45 08             	mov    0x8(%ebp),%eax
 92a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 931:	90                   	nop
}
 932:	5d                   	pop    %ebp
 933:	c3                   	ret    

00000934 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 934:	55                   	push   %ebp
 935:	89 e5                	mov    %esp,%ebp
 937:	53                   	push   %ebx
 938:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 93b:	8b 45 08             	mov    0x8(%ebp),%eax
 93e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 941:	8b 45 0c             	mov    0xc(%ebp),%eax
 944:	89 04 24             	mov    %eax,(%esp)
 947:	e8 b3 ff ff ff       	call   8ff <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 94c:	eb 09                	jmp    957 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 94e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 951:	8b 40 04             	mov    0x4(%eax),%eax
 954:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 957:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95a:	8b 40 04             	mov    0x4(%eax),%eax
 95d:	85 c0                	test   %eax,%eax
 95f:	75 ed                	jne    94e <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 961:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 968:	e8 b4 fd ff ff       	call   721 <malloc>
 96d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 970:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 973:	8b 45 f4             	mov    -0xc(%ebp),%eax
 976:	8b 58 04             	mov    0x4(%eax),%ebx
 979:	e8 8e f9 ff ff       	call   30c <getpid>
 97e:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 980:	8b 45 f4             	mov    -0xc(%ebp),%eax
 983:	8b 40 04             	mov    0x4(%eax),%eax
 986:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 98d:	8b 45 0c             	mov    0xc(%ebp),%eax
 990:	89 04 24             	mov    %eax,(%esp)
 993:	e8 46 ff ff ff       	call   8de <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 998:	8b 45 0c             	mov    0xc(%ebp),%eax
 99b:	89 04 24             	mov    %eax,(%esp)
 99e:	e8 5c ff ff ff       	call   8ff <pthread_mutex_unlock>
  threadSleep(mutex);
 9a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 9a6:	89 04 24             	mov    %eax,(%esp)
 9a9:	e8 96 f9 ff ff       	call   344 <threadSleep>
  pthread_mutex_lock(mutex);
 9ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 9b1:	89 04 24             	mov    %eax,(%esp)
 9b4:	e8 25 ff ff ff       	call   8de <pthread_mutex_lock>
  return;
 9b9:	90                   	nop
}
 9ba:	83 c4 24             	add    $0x24,%esp
 9bd:	5b                   	pop    %ebx
 9be:	5d                   	pop    %ebp
 9bf:	c3                   	ret    

000009c0 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 9c6:	8b 45 08             	mov    0x8(%ebp),%eax
 9c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 9cc:	eb 09                	jmp    9d7 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 9ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d1:	8b 40 04             	mov    0x4(%eax),%eax
 9d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 9d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9da:	8b 00                	mov    (%eax),%eax
 9dc:	83 f8 ff             	cmp    $0xffffffff,%eax
 9df:	74 ed                	je     9ce <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 9e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9e5:	74 33                	je     a1a <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 9e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ea:	8b 00                	mov    (%eax),%eax
 9ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 9ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 9f5:	8b 45 08             	mov    0x8(%ebp),%eax
 9f8:	8b 40 04             	mov    0x4(%eax),%eax
 9fb:	8b 50 04             	mov    0x4(%eax),%edx
 9fe:	8b 45 08             	mov    0x8(%ebp),%eax
 a01:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 a04:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a07:	89 04 24             	mov    %eax,(%esp)
 a0a:	e8 d9 fb ff ff       	call   5e8 <free>
    threadWake(threadId);
 a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a12:	89 04 24             	mov    %eax,(%esp)
 a15:	e8 32 f9 ff ff       	call   34c <threadWake>
  }
  return;
 a1a:	90                   	nop
}
 a1b:	c9                   	leave  
 a1c:	c3                   	ret    

00000a1d <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 a1d:	55                   	push   %ebp
 a1e:	89 e5                	mov    %esp,%ebp
 a20:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 a23:	8b 45 08             	mov    0x8(%ebp),%eax
 a26:	8b 55 10             	mov    0x10(%ebp),%edx
 a29:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 a2b:	8b 45 08             	mov    0x8(%ebp),%eax
 a2e:	83 c0 04             	add    $0x4,%eax
 a31:	89 04 24             	mov    %eax,(%esp)
 a34:	e8 e2 fe ff ff       	call   91b <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 a39:	8b 45 08             	mov    0x8(%ebp),%eax
 a3c:	83 c0 0c             	add    $0xc,%eax
 a3f:	89 04 24             	mov    %eax,(%esp)
 a42:	e8 88 fe ff ff       	call   8cf <pthread_mutex_init>
  return;
 a47:	90                   	nop
}
 a48:	c9                   	leave  
 a49:	c3                   	ret    

00000a4a <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 a4a:	55                   	push   %ebp
 a4b:	89 e5                	mov    %esp,%ebp
 a4d:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 a50:	8b 45 08             	mov    0x8(%ebp),%eax
 a53:	8b 00                	mov    (%eax),%eax
 a55:	8d 50 ff             	lea    -0x1(%eax),%edx
 a58:	8b 45 08             	mov    0x8(%ebp),%eax
 a5b:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 a5d:	8b 45 08             	mov    0x8(%ebp),%eax
 a60:	8b 00                	mov    (%eax),%eax
 a62:	85 c0                	test   %eax,%eax
 a64:	79 18                	jns    a7e <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 a66:	8b 45 08             	mov    0x8(%ebp),%eax
 a69:	8d 50 0c             	lea    0xc(%eax),%edx
 a6c:	8b 45 08             	mov    0x8(%ebp),%eax
 a6f:	83 c0 04             	add    $0x4,%eax
 a72:	89 54 24 04          	mov    %edx,0x4(%esp)
 a76:	89 04 24             	mov    %eax,(%esp)
 a79:	e8 b6 fe ff ff       	call   934 <pthread_cond_wait>
  }
  return;
 a7e:	90                   	nop
}
 a7f:	c9                   	leave  
 a80:	c3                   	ret    

00000a81 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 a81:	55                   	push   %ebp
 a82:	89 e5                	mov    %esp,%ebp
 a84:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 a87:	8b 45 08             	mov    0x8(%ebp),%eax
 a8a:	8b 00                	mov    (%eax),%eax
 a8c:	8d 50 01             	lea    0x1(%eax),%edx
 a8f:	8b 45 08             	mov    0x8(%ebp),%eax
 a92:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 a94:	8b 45 08             	mov    0x8(%ebp),%eax
 a97:	83 c0 04             	add    $0x4,%eax
 a9a:	89 04 24             	mov    %eax,(%esp)
 a9d:	e8 1e ff ff ff       	call   9c0 <pthread_cond_signal>
  return;
 aa2:	90                   	nop
}
 aa3:	c9                   	leave  
 aa4:	c3                   	ret    
