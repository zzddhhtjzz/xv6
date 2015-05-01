
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   9:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
   d:	74 19                	je     28 <main+0x28>
    printf(2, "Usage: ln old new\n");
   f:	c7 44 24 04 00 0b 00 	movl   $0xb00,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 69 04 00 00       	call   48c <printf>
    exit();
  23:	e8 bc 02 00 00       	call   2e4 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  28:	8b 45 0c             	mov    0xc(%ebp),%eax
  2b:	83 c0 08             	add    $0x8,%eax
  2e:	8b 10                	mov    (%eax),%edx
  30:	8b 45 0c             	mov    0xc(%ebp),%eax
  33:	83 c0 04             	add    $0x4,%eax
  36:	8b 00                	mov    (%eax),%eax
  38:	89 54 24 04          	mov    %edx,0x4(%esp)
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 00 03 00 00       	call   344 <link>
  44:	85 c0                	test   %eax,%eax
  46:	79 2c                	jns    74 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	8b 45 0c             	mov    0xc(%ebp),%eax
  4b:	83 c0 08             	add    $0x8,%eax
  4e:	8b 10                	mov    (%eax),%edx
  50:	8b 45 0c             	mov    0xc(%ebp),%eax
  53:	83 c0 04             	add    $0x4,%eax
  56:	8b 00                	mov    (%eax),%eax
  58:	89 54 24 0c          	mov    %edx,0xc(%esp)
  5c:	89 44 24 08          	mov    %eax,0x8(%esp)
  60:	c7 44 24 04 13 0b 00 	movl   $0xb13,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	e8 18 04 00 00       	call   48c <printf>
  exit();
  74:	e8 6b 02 00 00       	call   2e4 <exit>
  79:	66 90                	xchg   %ax,%ax
  7b:	90                   	nop

0000007c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	57                   	push   %edi
  80:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  81:	8b 4d 08             	mov    0x8(%ebp),%ecx
  84:	8b 55 10             	mov    0x10(%ebp),%edx
  87:	8b 45 0c             	mov    0xc(%ebp),%eax
  8a:	89 cb                	mov    %ecx,%ebx
  8c:	89 df                	mov    %ebx,%edi
  8e:	89 d1                	mov    %edx,%ecx
  90:	fc                   	cld    
  91:	f3 aa                	rep stos %al,%es:(%edi)
  93:	89 ca                	mov    %ecx,%edx
  95:	89 fb                	mov    %edi,%ebx
  97:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9d:	5b                   	pop    %ebx
  9e:	5f                   	pop    %edi
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    

000000a1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a1:	55                   	push   %ebp
  a2:	89 e5                	mov    %esp,%ebp
  a4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a7:	8b 45 08             	mov    0x8(%ebp),%eax
  aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ad:	90                   	nop
  ae:	8b 45 08             	mov    0x8(%ebp),%eax
  b1:	8d 50 01             	lea    0x1(%eax),%edx
  b4:	89 55 08             	mov    %edx,0x8(%ebp)
  b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  ba:	8d 4a 01             	lea    0x1(%edx),%ecx
  bd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  c0:	0f b6 12             	movzbl (%edx),%edx
  c3:	88 10                	mov    %dl,(%eax)
  c5:	0f b6 00             	movzbl (%eax),%eax
  c8:	84 c0                	test   %al,%al
  ca:	75 e2                	jne    ae <strcpy+0xd>
    ;
  return os;
  cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  cf:	c9                   	leave  
  d0:	c3                   	ret    

000000d1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d1:	55                   	push   %ebp
  d2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d4:	eb 08                	jmp    de <strcmp+0xd>
    p++, q++;
  d6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  da:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  de:	8b 45 08             	mov    0x8(%ebp),%eax
  e1:	0f b6 00             	movzbl (%eax),%eax
  e4:	84 c0                	test   %al,%al
  e6:	74 10                	je     f8 <strcmp+0x27>
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	0f b6 10             	movzbl (%eax),%edx
  ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	38 c2                	cmp    %al,%dl
  f6:	74 de                	je     d6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f8:	8b 45 08             	mov    0x8(%ebp),%eax
  fb:	0f b6 00             	movzbl (%eax),%eax
  fe:	0f b6 d0             	movzbl %al,%edx
 101:	8b 45 0c             	mov    0xc(%ebp),%eax
 104:	0f b6 00             	movzbl (%eax),%eax
 107:	0f b6 c0             	movzbl %al,%eax
 10a:	29 c2                	sub    %eax,%edx
 10c:	89 d0                	mov    %edx,%eax
}
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    

00000110 <strlen>:

uint
strlen(char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 116:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 11d:	eb 04                	jmp    123 <strlen+0x13>
 11f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 123:	8b 55 fc             	mov    -0x4(%ebp),%edx
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	01 d0                	add    %edx,%eax
 12b:	0f b6 00             	movzbl (%eax),%eax
 12e:	84 c0                	test   %al,%al
 130:	75 ed                	jne    11f <strlen+0xf>
    ;
  return n;
 132:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 135:	c9                   	leave  
 136:	c3                   	ret    

00000137 <memset>:

void*
memset(void *dst, int c, uint n)
{
 137:	55                   	push   %ebp
 138:	89 e5                	mov    %esp,%ebp
 13a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 13d:	8b 45 10             	mov    0x10(%ebp),%eax
 140:	89 44 24 08          	mov    %eax,0x8(%esp)
 144:	8b 45 0c             	mov    0xc(%ebp),%eax
 147:	89 44 24 04          	mov    %eax,0x4(%esp)
 14b:	8b 45 08             	mov    0x8(%ebp),%eax
 14e:	89 04 24             	mov    %eax,(%esp)
 151:	e8 26 ff ff ff       	call   7c <stosb>
  return dst;
 156:	8b 45 08             	mov    0x8(%ebp),%eax
}
 159:	c9                   	leave  
 15a:	c3                   	ret    

0000015b <strchr>:

char*
strchr(const char *s, char c)
{
 15b:	55                   	push   %ebp
 15c:	89 e5                	mov    %esp,%ebp
 15e:	83 ec 04             	sub    $0x4,%esp
 161:	8b 45 0c             	mov    0xc(%ebp),%eax
 164:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 167:	eb 14                	jmp    17d <strchr+0x22>
    if(*s == c)
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 172:	75 05                	jne    179 <strchr+0x1e>
      return (char*)s;
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	eb 13                	jmp    18c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 179:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	0f b6 00             	movzbl (%eax),%eax
 183:	84 c0                	test   %al,%al
 185:	75 e2                	jne    169 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 187:	b8 00 00 00 00       	mov    $0x0,%eax
}
 18c:	c9                   	leave  
 18d:	c3                   	ret    

0000018e <gets>:

char*
gets(char *buf, int max)
{
 18e:	55                   	push   %ebp
 18f:	89 e5                	mov    %esp,%ebp
 191:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 194:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 19b:	eb 4c                	jmp    1e9 <gets+0x5b>
    cc = read(0, &c, 1);
 19d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a4:	00 
 1a5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b3:	e8 44 01 00 00       	call   2fc <read>
 1b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1bf:	7f 02                	jg     1c3 <gets+0x35>
      break;
 1c1:	eb 31                	jmp    1f4 <gets+0x66>
    buf[i++] = c;
 1c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c6:	8d 50 01             	lea    0x1(%eax),%edx
 1c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1cc:	89 c2                	mov    %eax,%edx
 1ce:	8b 45 08             	mov    0x8(%ebp),%eax
 1d1:	01 c2                	add    %eax,%edx
 1d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1dd:	3c 0a                	cmp    $0xa,%al
 1df:	74 13                	je     1f4 <gets+0x66>
 1e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e5:	3c 0d                	cmp    $0xd,%al
 1e7:	74 0b                	je     1f4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ec:	83 c0 01             	add    $0x1,%eax
 1ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f2:	7c a9                	jl     19d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	01 d0                	add    %edx,%eax
 1fc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
 202:	c9                   	leave  
 203:	c3                   	ret    

00000204 <stat>:

int
stat(char *n, struct stat *st)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 211:	00 
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	89 04 24             	mov    %eax,(%esp)
 218:	e8 07 01 00 00       	call   324 <open>
 21d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 220:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 224:	79 07                	jns    22d <stat+0x29>
    return -1;
 226:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22b:	eb 23                	jmp    250 <stat+0x4c>
  r = fstat(fd, st);
 22d:	8b 45 0c             	mov    0xc(%ebp),%eax
 230:	89 44 24 04          	mov    %eax,0x4(%esp)
 234:	8b 45 f4             	mov    -0xc(%ebp),%eax
 237:	89 04 24             	mov    %eax,(%esp)
 23a:	e8 fd 00 00 00       	call   33c <fstat>
 23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 242:	8b 45 f4             	mov    -0xc(%ebp),%eax
 245:	89 04 24             	mov    %eax,(%esp)
 248:	e8 bf 00 00 00       	call   30c <close>
  return r;
 24d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 250:	c9                   	leave  
 251:	c3                   	ret    

00000252 <atoi>:

int
atoi(const char *s)
{
 252:	55                   	push   %ebp
 253:	89 e5                	mov    %esp,%ebp
 255:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25f:	eb 25                	jmp    286 <atoi+0x34>
    n = n*10 + *s++ - '0';
 261:	8b 55 fc             	mov    -0x4(%ebp),%edx
 264:	89 d0                	mov    %edx,%eax
 266:	c1 e0 02             	shl    $0x2,%eax
 269:	01 d0                	add    %edx,%eax
 26b:	01 c0                	add    %eax,%eax
 26d:	89 c1                	mov    %eax,%ecx
 26f:	8b 45 08             	mov    0x8(%ebp),%eax
 272:	8d 50 01             	lea    0x1(%eax),%edx
 275:	89 55 08             	mov    %edx,0x8(%ebp)
 278:	0f b6 00             	movzbl (%eax),%eax
 27b:	0f be c0             	movsbl %al,%eax
 27e:	01 c8                	add    %ecx,%eax
 280:	83 e8 30             	sub    $0x30,%eax
 283:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	0f b6 00             	movzbl (%eax),%eax
 28c:	3c 2f                	cmp    $0x2f,%al
 28e:	7e 0a                	jle    29a <atoi+0x48>
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	0f b6 00             	movzbl (%eax),%eax
 296:	3c 39                	cmp    $0x39,%al
 298:	7e c7                	jle    261 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29d:	c9                   	leave  
 29e:	c3                   	ret    

0000029f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 29f:	55                   	push   %ebp
 2a0:	89 e5                	mov    %esp,%ebp
 2a2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b1:	eb 17                	jmp    2ca <memmove+0x2b>
    *dst++ = *src++;
 2b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b6:	8d 50 01             	lea    0x1(%eax),%edx
 2b9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2bf:	8d 4a 01             	lea    0x1(%edx),%ecx
 2c2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c5:	0f b6 12             	movzbl (%edx),%edx
 2c8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ca:	8b 45 10             	mov    0x10(%ebp),%eax
 2cd:	8d 50 ff             	lea    -0x1(%eax),%edx
 2d0:	89 55 10             	mov    %edx,0x10(%ebp)
 2d3:	85 c0                	test   %eax,%eax
 2d5:	7f dc                	jg     2b3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2da:	c9                   	leave  
 2db:	c3                   	ret    

000002dc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2dc:	b8 01 00 00 00       	mov    $0x1,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <exit>:
SYSCALL(exit)
 2e4:	b8 02 00 00 00       	mov    $0x2,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <wait>:
SYSCALL(wait)
 2ec:	b8 03 00 00 00       	mov    $0x3,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <pipe>:
SYSCALL(pipe)
 2f4:	b8 04 00 00 00       	mov    $0x4,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <read>:
SYSCALL(read)
 2fc:	b8 05 00 00 00       	mov    $0x5,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <write>:
SYSCALL(write)
 304:	b8 10 00 00 00       	mov    $0x10,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <close>:
SYSCALL(close)
 30c:	b8 15 00 00 00       	mov    $0x15,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <kill>:
SYSCALL(kill)
 314:	b8 06 00 00 00       	mov    $0x6,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <exec>:
SYSCALL(exec)
 31c:	b8 07 00 00 00       	mov    $0x7,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <open>:
SYSCALL(open)
 324:	b8 0f 00 00 00       	mov    $0xf,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <mknod>:
SYSCALL(mknod)
 32c:	b8 11 00 00 00       	mov    $0x11,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <unlink>:
SYSCALL(unlink)
 334:	b8 12 00 00 00       	mov    $0x12,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <fstat>:
SYSCALL(fstat)
 33c:	b8 08 00 00 00       	mov    $0x8,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <link>:
SYSCALL(link)
 344:	b8 13 00 00 00       	mov    $0x13,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <mkdir>:
SYSCALL(mkdir)
 34c:	b8 14 00 00 00       	mov    $0x14,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <chdir>:
SYSCALL(chdir)
 354:	b8 09 00 00 00       	mov    $0x9,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <dup>:
SYSCALL(dup)
 35c:	b8 0a 00 00 00       	mov    $0xa,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <getpid>:
SYSCALL(getpid)
 364:	b8 0b 00 00 00       	mov    $0xb,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <sbrk>:
SYSCALL(sbrk)
 36c:	b8 0c 00 00 00       	mov    $0xc,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <sleep>:
SYSCALL(sleep)
 374:	b8 0d 00 00 00       	mov    $0xd,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <uptime>:
SYSCALL(uptime)
 37c:	b8 0e 00 00 00       	mov    $0xe,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <date>:
SYSCALL(date)
 384:	b8 16 00 00 00       	mov    $0x16,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <clone>:
SYSCALL(clone)
 38c:	b8 17 00 00 00       	mov    $0x17,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <join>:
SYSCALL(join)
 394:	b8 18 00 00 00       	mov    $0x18,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <threadSleep>:
SYSCALL(threadSleep)
 39c:	b8 19 00 00 00       	mov    $0x19,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <threadWake>:
SYSCALL(threadWake)
 3a4:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ac:	55                   	push   %ebp
 3ad:	89 e5                	mov    %esp,%ebp
 3af:	83 ec 18             	sub    $0x18,%esp
 3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3bf:	00 
 3c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	89 04 24             	mov    %eax,(%esp)
 3cd:	e8 32 ff ff ff       	call   304 <write>
}
 3d2:	c9                   	leave  
 3d3:	c3                   	ret    

000003d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	56                   	push   %esi
 3d8:	53                   	push   %ebx
 3d9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3e3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3e7:	74 17                	je     400 <printint+0x2c>
 3e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3ed:	79 11                	jns    400 <printint+0x2c>
    neg = 1;
 3ef:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f9:	f7 d8                	neg    %eax
 3fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3fe:	eb 06                	jmp    406 <printint+0x32>
  } else {
    x = xx;
 400:	8b 45 0c             	mov    0xc(%ebp),%eax
 403:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 406:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 40d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 410:	8d 41 01             	lea    0x1(%ecx),%eax
 413:	89 45 f4             	mov    %eax,-0xc(%ebp)
 416:	8b 5d 10             	mov    0x10(%ebp),%ebx
 419:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41c:	ba 00 00 00 00       	mov    $0x0,%edx
 421:	f7 f3                	div    %ebx
 423:	89 d0                	mov    %edx,%eax
 425:	0f b6 80 24 0f 00 00 	movzbl 0xf24(%eax),%eax
 42c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 430:	8b 75 10             	mov    0x10(%ebp),%esi
 433:	8b 45 ec             	mov    -0x14(%ebp),%eax
 436:	ba 00 00 00 00       	mov    $0x0,%edx
 43b:	f7 f6                	div    %esi
 43d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 440:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 444:	75 c7                	jne    40d <printint+0x39>
  if(neg)
 446:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 44a:	74 10                	je     45c <printint+0x88>
    buf[i++] = '-';
 44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44f:	8d 50 01             	lea    0x1(%eax),%edx
 452:	89 55 f4             	mov    %edx,-0xc(%ebp)
 455:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 45a:	eb 1f                	jmp    47b <printint+0xa7>
 45c:	eb 1d                	jmp    47b <printint+0xa7>
    putc(fd, buf[i]);
 45e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 461:	8b 45 f4             	mov    -0xc(%ebp),%eax
 464:	01 d0                	add    %edx,%eax
 466:	0f b6 00             	movzbl (%eax),%eax
 469:	0f be c0             	movsbl %al,%eax
 46c:	89 44 24 04          	mov    %eax,0x4(%esp)
 470:	8b 45 08             	mov    0x8(%ebp),%eax
 473:	89 04 24             	mov    %eax,(%esp)
 476:	e8 31 ff ff ff       	call   3ac <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 47b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 47f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 483:	79 d9                	jns    45e <printint+0x8a>
    putc(fd, buf[i]);
}
 485:	83 c4 30             	add    $0x30,%esp
 488:	5b                   	pop    %ebx
 489:	5e                   	pop    %esi
 48a:	5d                   	pop    %ebp
 48b:	c3                   	ret    

0000048c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 492:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 499:	8d 45 0c             	lea    0xc(%ebp),%eax
 49c:	83 c0 04             	add    $0x4,%eax
 49f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4a9:	e9 7c 01 00 00       	jmp    62a <printf+0x19e>
    c = fmt[i] & 0xff;
 4ae:	8b 55 0c             	mov    0xc(%ebp),%edx
 4b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4b4:	01 d0                	add    %edx,%eax
 4b6:	0f b6 00             	movzbl (%eax),%eax
 4b9:	0f be c0             	movsbl %al,%eax
 4bc:	25 ff 00 00 00       	and    $0xff,%eax
 4c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4c8:	75 2c                	jne    4f6 <printf+0x6a>
      if(c == '%'){
 4ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ce:	75 0c                	jne    4dc <printf+0x50>
        state = '%';
 4d0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4d7:	e9 4a 01 00 00       	jmp    626 <printf+0x19a>
      } else {
        putc(fd, c);
 4dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4df:	0f be c0             	movsbl %al,%eax
 4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e6:	8b 45 08             	mov    0x8(%ebp),%eax
 4e9:	89 04 24             	mov    %eax,(%esp)
 4ec:	e8 bb fe ff ff       	call   3ac <putc>
 4f1:	e9 30 01 00 00       	jmp    626 <printf+0x19a>
      }
    } else if(state == '%'){
 4f6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4fa:	0f 85 26 01 00 00    	jne    626 <printf+0x19a>
      if(c == 'd'){
 500:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 504:	75 2d                	jne    533 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 506:	8b 45 e8             	mov    -0x18(%ebp),%eax
 509:	8b 00                	mov    (%eax),%eax
 50b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 512:	00 
 513:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 51a:	00 
 51b:	89 44 24 04          	mov    %eax,0x4(%esp)
 51f:	8b 45 08             	mov    0x8(%ebp),%eax
 522:	89 04 24             	mov    %eax,(%esp)
 525:	e8 aa fe ff ff       	call   3d4 <printint>
        ap++;
 52a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52e:	e9 ec 00 00 00       	jmp    61f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 533:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 537:	74 06                	je     53f <printf+0xb3>
 539:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 53d:	75 2d                	jne    56c <printf+0xe0>
        printint(fd, *ap, 16, 0);
 53f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 542:	8b 00                	mov    (%eax),%eax
 544:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 54b:	00 
 54c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 553:	00 
 554:	89 44 24 04          	mov    %eax,0x4(%esp)
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	89 04 24             	mov    %eax,(%esp)
 55e:	e8 71 fe ff ff       	call   3d4 <printint>
        ap++;
 563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 567:	e9 b3 00 00 00       	jmp    61f <printf+0x193>
      } else if(c == 's'){
 56c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 570:	75 45                	jne    5b7 <printf+0x12b>
        s = (char*)*ap;
 572:	8b 45 e8             	mov    -0x18(%ebp),%eax
 575:	8b 00                	mov    (%eax),%eax
 577:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 582:	75 09                	jne    58d <printf+0x101>
          s = "(null)";
 584:	c7 45 f4 27 0b 00 00 	movl   $0xb27,-0xc(%ebp)
        while(*s != 0){
 58b:	eb 1e                	jmp    5ab <printf+0x11f>
 58d:	eb 1c                	jmp    5ab <printf+0x11f>
          putc(fd, *s);
 58f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 592:	0f b6 00             	movzbl (%eax),%eax
 595:	0f be c0             	movsbl %al,%eax
 598:	89 44 24 04          	mov    %eax,0x4(%esp)
 59c:	8b 45 08             	mov    0x8(%ebp),%eax
 59f:	89 04 24             	mov    %eax,(%esp)
 5a2:	e8 05 fe ff ff       	call   3ac <putc>
          s++;
 5a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ae:	0f b6 00             	movzbl (%eax),%eax
 5b1:	84 c0                	test   %al,%al
 5b3:	75 da                	jne    58f <printf+0x103>
 5b5:	eb 68                	jmp    61f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5bb:	75 1d                	jne    5da <printf+0x14e>
        putc(fd, *ap);
 5bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c0:	8b 00                	mov    (%eax),%eax
 5c2:	0f be c0             	movsbl %al,%eax
 5c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c9:	8b 45 08             	mov    0x8(%ebp),%eax
 5cc:	89 04 24             	mov    %eax,(%esp)
 5cf:	e8 d8 fd ff ff       	call   3ac <putc>
        ap++;
 5d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d8:	eb 45                	jmp    61f <printf+0x193>
      } else if(c == '%'){
 5da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5de:	75 17                	jne    5f7 <printf+0x16b>
        putc(fd, c);
 5e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e3:	0f be c0             	movsbl %al,%eax
 5e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ea:	8b 45 08             	mov    0x8(%ebp),%eax
 5ed:	89 04 24             	mov    %eax,(%esp)
 5f0:	e8 b7 fd ff ff       	call   3ac <putc>
 5f5:	eb 28                	jmp    61f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f7:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5fe:	00 
 5ff:	8b 45 08             	mov    0x8(%ebp),%eax
 602:	89 04 24             	mov    %eax,(%esp)
 605:	e8 a2 fd ff ff       	call   3ac <putc>
        putc(fd, c);
 60a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60d:	0f be c0             	movsbl %al,%eax
 610:	89 44 24 04          	mov    %eax,0x4(%esp)
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	89 04 24             	mov    %eax,(%esp)
 61a:	e8 8d fd ff ff       	call   3ac <putc>
      }
      state = 0;
 61f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 626:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 62a:	8b 55 0c             	mov    0xc(%ebp),%edx
 62d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 630:	01 d0                	add    %edx,%eax
 632:	0f b6 00             	movzbl (%eax),%eax
 635:	84 c0                	test   %al,%al
 637:	0f 85 71 fe ff ff    	jne    4ae <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 63d:	c9                   	leave  
 63e:	c3                   	ret    
 63f:	90                   	nop

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 646:	8b 45 08             	mov    0x8(%ebp),%eax
 649:	83 e8 08             	sub    $0x8,%eax
 64c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64f:	a1 40 0f 00 00       	mov    0xf40,%eax
 654:	89 45 fc             	mov    %eax,-0x4(%ebp)
 657:	eb 24                	jmp    67d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 659:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65c:	8b 00                	mov    (%eax),%eax
 65e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 661:	77 12                	ja     675 <free+0x35>
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 669:	77 24                	ja     68f <free+0x4f>
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	8b 00                	mov    (%eax),%eax
 670:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 673:	77 1a                	ja     68f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 680:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 683:	76 d4                	jbe    659 <free+0x19>
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 00                	mov    (%eax),%eax
 68a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68d:	76 ca                	jbe    659 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	8b 40 04             	mov    0x4(%eax),%eax
 695:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69f:	01 c2                	add    %eax,%edx
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	39 c2                	cmp    %eax,%edx
 6a8:	75 24                	jne    6ce <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	8b 00                	mov    (%eax),%eax
 6b5:	8b 40 04             	mov    0x4(%eax),%eax
 6b8:	01 c2                	add    %eax,%edx
 6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	8b 00                	mov    (%eax),%eax
 6c5:	8b 10                	mov    (%eax),%edx
 6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ca:	89 10                	mov    %edx,(%eax)
 6cc:	eb 0a                	jmp    6d8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d1:	8b 10                	mov    (%eax),%edx
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 40 04             	mov    0x4(%eax),%eax
 6de:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	01 d0                	add    %edx,%eax
 6ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ed:	75 20                	jne    70f <free+0xcf>
    p->s.size += bp->s.size;
 6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f2:	8b 50 04             	mov    0x4(%eax),%edx
 6f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f8:	8b 40 04             	mov    0x4(%eax),%eax
 6fb:	01 c2                	add    %eax,%edx
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	8b 10                	mov    (%eax),%edx
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	89 10                	mov    %edx,(%eax)
 70d:	eb 08                	jmp    717 <free+0xd7>
  } else
    p->s.ptr = bp;
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	8b 55 f8             	mov    -0x8(%ebp),%edx
 715:	89 10                	mov    %edx,(%eax)
  freep = p;
 717:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71a:	a3 40 0f 00 00       	mov    %eax,0xf40
}
 71f:	c9                   	leave  
 720:	c3                   	ret    

00000721 <morecore>:

static Header*
morecore(uint nu)
{
 721:	55                   	push   %ebp
 722:	89 e5                	mov    %esp,%ebp
 724:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 727:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 72e:	77 07                	ja     737 <morecore+0x16>
    nu = 4096;
 730:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 737:	8b 45 08             	mov    0x8(%ebp),%eax
 73a:	c1 e0 03             	shl    $0x3,%eax
 73d:	89 04 24             	mov    %eax,(%esp)
 740:	e8 27 fc ff ff       	call   36c <sbrk>
 745:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 748:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74c:	75 07                	jne    755 <morecore+0x34>
    return 0;
 74e:	b8 00 00 00 00       	mov    $0x0,%eax
 753:	eb 22                	jmp    777 <morecore+0x56>
  hp = (Header*)p;
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75e:	8b 55 08             	mov    0x8(%ebp),%edx
 761:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 764:	8b 45 f0             	mov    -0x10(%ebp),%eax
 767:	83 c0 08             	add    $0x8,%eax
 76a:	89 04 24             	mov    %eax,(%esp)
 76d:	e8 ce fe ff ff       	call   640 <free>
  return freep;
 772:	a1 40 0f 00 00       	mov    0xf40,%eax
}
 777:	c9                   	leave  
 778:	c3                   	ret    

00000779 <malloc>:

void*
malloc(uint nbytes)
{
 779:	55                   	push   %ebp
 77a:	89 e5                	mov    %esp,%ebp
 77c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77f:	8b 45 08             	mov    0x8(%ebp),%eax
 782:	83 c0 07             	add    $0x7,%eax
 785:	c1 e8 03             	shr    $0x3,%eax
 788:	83 c0 01             	add    $0x1,%eax
 78b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 78e:	a1 40 0f 00 00       	mov    0xf40,%eax
 793:	89 45 f0             	mov    %eax,-0x10(%ebp)
 796:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79a:	75 23                	jne    7bf <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79c:	c7 45 f0 38 0f 00 00 	movl   $0xf38,-0x10(%ebp)
 7a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a6:	a3 40 0f 00 00       	mov    %eax,0xf40
 7ab:	a1 40 0f 00 00       	mov    0xf40,%eax
 7b0:	a3 38 0f 00 00       	mov    %eax,0xf38
    base.s.size = 0;
 7b5:	c7 05 3c 0f 00 00 00 	movl   $0x0,0xf3c
 7bc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c2:	8b 00                	mov    (%eax),%eax
 7c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ca:	8b 40 04             	mov    0x4(%eax),%eax
 7cd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d0:	72 4d                	jb     81f <malloc+0xa6>
      if(p->s.size == nunits)
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	8b 40 04             	mov    0x4(%eax),%eax
 7d8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7db:	75 0c                	jne    7e9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e0:	8b 10                	mov    (%eax),%edx
 7e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e5:	89 10                	mov    %edx,(%eax)
 7e7:	eb 26                	jmp    80f <malloc+0x96>
      else {
        p->s.size -= nunits;
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	8b 40 04             	mov    0x4(%eax),%eax
 7ef:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f2:	89 c2                	mov    %eax,%edx
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fd:	8b 40 04             	mov    0x4(%eax),%eax
 800:	c1 e0 03             	shl    $0x3,%eax
 803:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 806:	8b 45 f4             	mov    -0xc(%ebp),%eax
 809:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 80f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 812:	a3 40 0f 00 00       	mov    %eax,0xf40
      return (void*)(p + 1);
 817:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81a:	83 c0 08             	add    $0x8,%eax
 81d:	eb 38                	jmp    857 <malloc+0xde>
    }
    if(p == freep)
 81f:	a1 40 0f 00 00       	mov    0xf40,%eax
 824:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 827:	75 1b                	jne    844 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 829:	8b 45 ec             	mov    -0x14(%ebp),%eax
 82c:	89 04 24             	mov    %eax,(%esp)
 82f:	e8 ed fe ff ff       	call   721 <morecore>
 834:	89 45 f4             	mov    %eax,-0xc(%ebp)
 837:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 83b:	75 07                	jne    844 <malloc+0xcb>
        return 0;
 83d:	b8 00 00 00 00       	mov    $0x0,%eax
 842:	eb 13                	jmp    857 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	8b 00                	mov    (%eax),%eax
 84f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 852:	e9 70 ff ff ff       	jmp    7c7 <malloc+0x4e>
}
 857:	c9                   	leave  
 858:	c3                   	ret    
 859:	66 90                	xchg   %ax,%ax
 85b:	90                   	nop

0000085c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 85c:	55                   	push   %ebp
 85d:	89 e5                	mov    %esp,%ebp
 85f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 862:	8b 55 08             	mov    0x8(%ebp),%edx
 865:	8b 45 0c             	mov    0xc(%ebp),%eax
 868:	8b 4d 08             	mov    0x8(%ebp),%ecx
 86b:	f0 87 02             	lock xchg %eax,(%edx)
 86e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 871:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 874:	c9                   	leave  
 875:	c3                   	ret    

00000876 <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 876:	55                   	push   %ebp
 877:	89 e5                	mov    %esp,%ebp
 879:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 87c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 883:	e8 f1 fe ff ff       	call   779 <malloc>
 888:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 88b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88e:	85 c0                	test   %eax,%eax
 890:	75 1b                	jne    8ad <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 892:	c7 44 24 04 30 0b 00 	movl   $0xb30,0x4(%esp)
 899:	00 
 89a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8a1:	e8 e6 fb ff ff       	call   48c <printf>
    return -1;
 8a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 8ab:	eb 43                	jmp    8f0 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 8ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b0:	25 ff 0f 00 00       	and    $0xfff,%eax
 8b5:	85 c0                	test   %eax,%eax
 8b7:	74 14                	je     8cd <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bc:	25 ff 0f 00 00       	and    $0xfff,%eax
 8c1:	89 c2                	mov    %eax,%edx
 8c3:	b8 00 10 00 00       	mov    $0x1000,%eax
 8c8:	29 d0                	sub    %edx,%eax
 8ca:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 8cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d0:	89 44 24 08          	mov    %eax,0x8(%esp)
 8d4:	8b 45 14             	mov    0x14(%ebp),%eax
 8d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 8db:	8b 45 10             	mov    0x10(%ebp),%eax
 8de:	89 04 24             	mov    %eax,(%esp)
 8e1:	e8 a6 fa ff ff       	call   38c <clone>
 8e6:	8b 55 08             	mov    0x8(%ebp),%edx
 8e9:	89 02                	mov    %eax,(%edx)
  return *thread;
 8eb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ee:	8b 00                	mov    (%eax),%eax
}
 8f0:	c9                   	leave  
 8f1:	c3                   	ret    

000008f2 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 8f2:	55                   	push   %ebp
 8f3:	89 e5                	mov    %esp,%ebp
 8f5:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 8f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 8fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ff:	8b 45 08             	mov    0x8(%ebp),%eax
 902:	89 04 24             	mov    %eax,(%esp)
 905:	e8 8a fa ff ff       	call   394 <join>
 90a:	85 c0                	test   %eax,%eax
 90c:	79 07                	jns    915 <pthread_join+0x23>
    return -1;
 90e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 913:	eb 10                	jmp    925 <pthread_join+0x33>
  }
  free(stack);
 915:	8b 45 f4             	mov    -0xc(%ebp),%eax
 918:	89 04 24             	mov    %eax,(%esp)
 91b:	e8 20 fd ff ff       	call   640 <free>
  return 0;
 920:	b8 00 00 00 00       	mov    $0x0,%eax
}
 925:	c9                   	leave  
 926:	c3                   	ret    

00000927 <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 927:	55                   	push   %ebp
 928:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 92a:	8b 45 08             	mov    0x8(%ebp),%eax
 92d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 933:	90                   	nop
}
 934:	5d                   	pop    %ebp
 935:	c3                   	ret    

00000936 <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 936:	55                   	push   %ebp
 937:	89 e5                	mov    %esp,%ebp
 939:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 93c:	90                   	nop
 93d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 944:	00 
 945:	8b 45 08             	mov    0x8(%ebp),%eax
 948:	89 04 24             	mov    %eax,(%esp)
 94b:	e8 0c ff ff ff       	call   85c <xchg>
 950:	85 c0                	test   %eax,%eax
 952:	75 e9                	jne    93d <pthread_mutex_lock+0x7>
  return;
 954:	90                   	nop
}
 955:	c9                   	leave  
 956:	c3                   	ret    

00000957 <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 957:	55                   	push   %ebp
 958:	89 e5                	mov    %esp,%ebp
 95a:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 95d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 964:	00 
 965:	8b 45 08             	mov    0x8(%ebp),%eax
 968:	89 04 24             	mov    %eax,(%esp)
 96b:	e8 ec fe ff ff       	call   85c <xchg>
  return;
 970:	90                   	nop
}
 971:	c9                   	leave  
 972:	c3                   	ret    

00000973 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 973:	55                   	push   %ebp
 974:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 976:	8b 45 08             	mov    0x8(%ebp),%eax
 979:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 97f:	8b 45 08             	mov    0x8(%ebp),%eax
 982:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 989:	90                   	nop
}
 98a:	5d                   	pop    %ebp
 98b:	c3                   	ret    

0000098c <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 98c:	55                   	push   %ebp
 98d:	89 e5                	mov    %esp,%ebp
 98f:	53                   	push   %ebx
 990:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 999:	8b 45 0c             	mov    0xc(%ebp),%eax
 99c:	89 04 24             	mov    %eax,(%esp)
 99f:	e8 b3 ff ff ff       	call   957 <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 9a4:	eb 09                	jmp    9af <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 9a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a9:	8b 40 04             	mov    0x4(%eax),%eax
 9ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 9af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b2:	8b 40 04             	mov    0x4(%eax),%eax
 9b5:	85 c0                	test   %eax,%eax
 9b7:	75 ed                	jne    9a6 <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 9b9:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 9c0:	e8 b4 fd ff ff       	call   779 <malloc>
 9c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9c8:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 9cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ce:	8b 58 04             	mov    0x4(%eax),%ebx
 9d1:	e8 8e f9 ff ff       	call   364 <getpid>
 9d6:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9db:	8b 40 04             	mov    0x4(%eax),%eax
 9de:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 9e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 9e8:	89 04 24             	mov    %eax,(%esp)
 9eb:	e8 46 ff ff ff       	call   936 <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 9f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 9f3:	89 04 24             	mov    %eax,(%esp)
 9f6:	e8 5c ff ff ff       	call   957 <pthread_mutex_unlock>
  threadSleep(mutex);
 9fb:	8b 45 0c             	mov    0xc(%ebp),%eax
 9fe:	89 04 24             	mov    %eax,(%esp)
 a01:	e8 96 f9 ff ff       	call   39c <threadSleep>
  pthread_mutex_lock(mutex);
 a06:	8b 45 0c             	mov    0xc(%ebp),%eax
 a09:	89 04 24             	mov    %eax,(%esp)
 a0c:	e8 25 ff ff ff       	call   936 <pthread_mutex_lock>
  return;
 a11:	90                   	nop
}
 a12:	83 c4 24             	add    $0x24,%esp
 a15:	5b                   	pop    %ebx
 a16:	5d                   	pop    %ebp
 a17:	c3                   	ret    

00000a18 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 a18:	55                   	push   %ebp
 a19:	89 e5                	mov    %esp,%ebp
 a1b:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 a1e:	8b 45 08             	mov    0x8(%ebp),%eax
 a21:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 a24:	eb 09                	jmp    a2f <pthread_cond_signal+0x17>
    mycond = mycond->next;
 a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a29:	8b 40 04             	mov    0x4(%eax),%eax
 a2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a32:	8b 00                	mov    (%eax),%eax
 a34:	83 f8 ff             	cmp    $0xffffffff,%eax
 a37:	74 ed                	je     a26 <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 a39:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a3d:	74 33                	je     a72 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a42:	8b 00                	mov    (%eax),%eax
 a44:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 a4d:	8b 45 08             	mov    0x8(%ebp),%eax
 a50:	8b 40 04             	mov    0x4(%eax),%eax
 a53:	8b 50 04             	mov    0x4(%eax),%edx
 a56:	8b 45 08             	mov    0x8(%ebp),%eax
 a59:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 a5c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a5f:	89 04 24             	mov    %eax,(%esp)
 a62:	e8 d9 fb ff ff       	call   640 <free>
    threadWake(threadId);
 a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a6a:	89 04 24             	mov    %eax,(%esp)
 a6d:	e8 32 f9 ff ff       	call   3a4 <threadWake>
  }
  return;
 a72:	90                   	nop
}
 a73:	c9                   	leave  
 a74:	c3                   	ret    

00000a75 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 a75:	55                   	push   %ebp
 a76:	89 e5                	mov    %esp,%ebp
 a78:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 a7b:	8b 45 08             	mov    0x8(%ebp),%eax
 a7e:	8b 55 10             	mov    0x10(%ebp),%edx
 a81:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 a83:	8b 45 08             	mov    0x8(%ebp),%eax
 a86:	83 c0 04             	add    $0x4,%eax
 a89:	89 04 24             	mov    %eax,(%esp)
 a8c:	e8 e2 fe ff ff       	call   973 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 a91:	8b 45 08             	mov    0x8(%ebp),%eax
 a94:	83 c0 0c             	add    $0xc,%eax
 a97:	89 04 24             	mov    %eax,(%esp)
 a9a:	e8 88 fe ff ff       	call   927 <pthread_mutex_init>
  return;
 a9f:	90                   	nop
}
 aa0:	c9                   	leave  
 aa1:	c3                   	ret    

00000aa2 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 aa2:	55                   	push   %ebp
 aa3:	89 e5                	mov    %esp,%ebp
 aa5:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 aa8:	8b 45 08             	mov    0x8(%ebp),%eax
 aab:	8b 00                	mov    (%eax),%eax
 aad:	8d 50 ff             	lea    -0x1(%eax),%edx
 ab0:	8b 45 08             	mov    0x8(%ebp),%eax
 ab3:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 ab5:	8b 45 08             	mov    0x8(%ebp),%eax
 ab8:	8b 00                	mov    (%eax),%eax
 aba:	85 c0                	test   %eax,%eax
 abc:	79 18                	jns    ad6 <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 abe:	8b 45 08             	mov    0x8(%ebp),%eax
 ac1:	8d 50 0c             	lea    0xc(%eax),%edx
 ac4:	8b 45 08             	mov    0x8(%ebp),%eax
 ac7:	83 c0 04             	add    $0x4,%eax
 aca:	89 54 24 04          	mov    %edx,0x4(%esp)
 ace:	89 04 24             	mov    %eax,(%esp)
 ad1:	e8 b6 fe ff ff       	call   98c <pthread_cond_wait>
  }
  return;
 ad6:	90                   	nop
}
 ad7:	c9                   	leave  
 ad8:	c3                   	ret    

00000ad9 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 ad9:	55                   	push   %ebp
 ada:	89 e5                	mov    %esp,%ebp
 adc:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 adf:	8b 45 08             	mov    0x8(%ebp),%eax
 ae2:	8b 00                	mov    (%eax),%eax
 ae4:	8d 50 01             	lea    0x1(%eax),%edx
 ae7:	8b 45 08             	mov    0x8(%ebp),%eax
 aea:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 aec:	8b 45 08             	mov    0x8(%ebp),%eax
 aef:	83 c0 04             	add    $0x4,%eax
 af2:	89 04 24             	mov    %eax,(%esp)
 af5:	e8 1e ff ff ff       	call   a18 <pthread_cond_signal>
  return;
 afa:	90                   	nop
}
 afb:	c9                   	leave  
 afc:	c3                   	ret    
