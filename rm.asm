
_rm:     file format elf32-i386


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
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "Usage: rm files...\n");
   f:	c7 44 24 04 14 0b 00 	movl   $0xb14,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 7d 04 00 00       	call   4a0 <printf>
    exit();
  23:	e8 d0 02 00 00       	call   2f8 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 4f                	jmp    81 <main+0x81>
    if(unlink(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 fc 02 00 00       	call   348 <unlink>
  4c:	85 c0                	test   %eax,%eax
  4e:	79 2c                	jns    7c <main+0x7c>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  50:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  5e:	01 d0                	add    %edx,%eax
  60:	8b 00                	mov    (%eax),%eax
  62:	89 44 24 08          	mov    %eax,0x8(%esp)
  66:	c7 44 24 04 28 0b 00 	movl   $0xb28,0x4(%esp)
  6d:	00 
  6e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  75:	e8 26 04 00 00       	call   4a0 <printf>
      break;
  7a:	eb 0e                	jmp    8a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  7c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  81:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  85:	3b 45 08             	cmp    0x8(%ebp),%eax
  88:	7c a8                	jl     32 <main+0x32>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  8a:	e8 69 02 00 00       	call   2f8 <exit>
  8f:	90                   	nop

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  98:	8b 55 10             	mov    0x10(%ebp),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	89 cb                	mov    %ecx,%ebx
  a0:	89 df                	mov    %ebx,%edi
  a2:	89 d1                	mov    %edx,%ecx
  a4:	fc                   	cld    
  a5:	f3 aa                	rep stos %al,%es:(%edi)
  a7:	89 ca                	mov    %ecx,%edx
  a9:	89 fb                	mov    %edi,%ebx
  ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b1:	5b                   	pop    %ebx
  b2:	5f                   	pop    %edi
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    

000000b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c1:	90                   	nop
  c2:	8b 45 08             	mov    0x8(%ebp),%eax
  c5:	8d 50 01             	lea    0x1(%eax),%edx
  c8:	89 55 08             	mov    %edx,0x8(%ebp)
  cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  ce:	8d 4a 01             	lea    0x1(%edx),%ecx
  d1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d4:	0f b6 12             	movzbl (%edx),%edx
  d7:	88 10                	mov    %dl,(%eax)
  d9:	0f b6 00             	movzbl (%eax),%eax
  dc:	84 c0                	test   %al,%al
  de:	75 e2                	jne    c2 <strcpy+0xd>
    ;
  return os;
  e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e3:	c9                   	leave  
  e4:	c3                   	ret    

000000e5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e5:	55                   	push   %ebp
  e6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e8:	eb 08                	jmp    f2 <strcmp+0xd>
    p++, q++;
  ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ee:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	84 c0                	test   %al,%al
  fa:	74 10                	je     10c <strcmp+0x27>
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 10             	movzbl (%eax),%edx
 102:	8b 45 0c             	mov    0xc(%ebp),%eax
 105:	0f b6 00             	movzbl (%eax),%eax
 108:	38 c2                	cmp    %al,%dl
 10a:	74 de                	je     ea <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	0f b6 00             	movzbl (%eax),%eax
 112:	0f b6 d0             	movzbl %al,%edx
 115:	8b 45 0c             	mov    0xc(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	0f b6 c0             	movzbl %al,%eax
 11e:	29 c2                	sub    %eax,%edx
 120:	89 d0                	mov    %edx,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    

00000124 <strlen>:

uint
strlen(char *s)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 12a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 131:	eb 04                	jmp    137 <strlen+0x13>
 133:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 137:	8b 55 fc             	mov    -0x4(%ebp),%edx
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	01 d0                	add    %edx,%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	84 c0                	test   %al,%al
 144:	75 ed                	jne    133 <strlen+0xf>
    ;
  return n;
 146:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 149:	c9                   	leave  
 14a:	c3                   	ret    

0000014b <memset>:

void*
memset(void *dst, int c, uint n)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 151:	8b 45 10             	mov    0x10(%ebp),%eax
 154:	89 44 24 08          	mov    %eax,0x8(%esp)
 158:	8b 45 0c             	mov    0xc(%ebp),%eax
 15b:	89 44 24 04          	mov    %eax,0x4(%esp)
 15f:	8b 45 08             	mov    0x8(%ebp),%eax
 162:	89 04 24             	mov    %eax,(%esp)
 165:	e8 26 ff ff ff       	call   90 <stosb>
  return dst;
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 16d:	c9                   	leave  
 16e:	c3                   	ret    

0000016f <strchr>:

char*
strchr(const char *s, char c)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	83 ec 04             	sub    $0x4,%esp
 175:	8b 45 0c             	mov    0xc(%ebp),%eax
 178:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 17b:	eb 14                	jmp    191 <strchr+0x22>
    if(*s == c)
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	0f b6 00             	movzbl (%eax),%eax
 183:	3a 45 fc             	cmp    -0x4(%ebp),%al
 186:	75 05                	jne    18d <strchr+0x1e>
      return (char*)s;
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	eb 13                	jmp    1a0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 18d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	0f b6 00             	movzbl (%eax),%eax
 197:	84 c0                	test   %al,%al
 199:	75 e2                	jne    17d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 19b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1a0:	c9                   	leave  
 1a1:	c3                   	ret    

000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	55                   	push   %ebp
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1af:	eb 4c                	jmp    1fd <gets+0x5b>
    cc = read(0, &c, 1);
 1b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1b8:	00 
 1b9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1c7:	e8 44 01 00 00       	call   310 <read>
 1cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1d3:	7f 02                	jg     1d7 <gets+0x35>
      break;
 1d5:	eb 31                	jmp    208 <gets+0x66>
    buf[i++] = c;
 1d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1da:	8d 50 01             	lea    0x1(%eax),%edx
 1dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1e0:	89 c2                	mov    %eax,%edx
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	01 c2                	add    %eax,%edx
 1e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f1:	3c 0a                	cmp    $0xa,%al
 1f3:	74 13                	je     208 <gets+0x66>
 1f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f9:	3c 0d                	cmp    $0xd,%al
 1fb:	74 0b                	je     208 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 200:	83 c0 01             	add    $0x1,%eax
 203:	3b 45 0c             	cmp    0xc(%ebp),%eax
 206:	7c a9                	jl     1b1 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 208:	8b 55 f4             	mov    -0xc(%ebp),%edx
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	01 d0                	add    %edx,%eax
 210:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 213:	8b 45 08             	mov    0x8(%ebp),%eax
}
 216:	c9                   	leave  
 217:	c3                   	ret    

00000218 <stat>:

int
stat(char *n, struct stat *st)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 225:	00 
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	89 04 24             	mov    %eax,(%esp)
 22c:	e8 07 01 00 00       	call   338 <open>
 231:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 234:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 238:	79 07                	jns    241 <stat+0x29>
    return -1;
 23a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23f:	eb 23                	jmp    264 <stat+0x4c>
  r = fstat(fd, st);
 241:	8b 45 0c             	mov    0xc(%ebp),%eax
 244:	89 44 24 04          	mov    %eax,0x4(%esp)
 248:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24b:	89 04 24             	mov    %eax,(%esp)
 24e:	e8 fd 00 00 00       	call   350 <fstat>
 253:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 256:	8b 45 f4             	mov    -0xc(%ebp),%eax
 259:	89 04 24             	mov    %eax,(%esp)
 25c:	e8 bf 00 00 00       	call   320 <close>
  return r;
 261:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 264:	c9                   	leave  
 265:	c3                   	ret    

00000266 <atoi>:

int
atoi(const char *s)
{
 266:	55                   	push   %ebp
 267:	89 e5                	mov    %esp,%ebp
 269:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 26c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 273:	eb 25                	jmp    29a <atoi+0x34>
    n = n*10 + *s++ - '0';
 275:	8b 55 fc             	mov    -0x4(%ebp),%edx
 278:	89 d0                	mov    %edx,%eax
 27a:	c1 e0 02             	shl    $0x2,%eax
 27d:	01 d0                	add    %edx,%eax
 27f:	01 c0                	add    %eax,%eax
 281:	89 c1                	mov    %eax,%ecx
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	8d 50 01             	lea    0x1(%eax),%edx
 289:	89 55 08             	mov    %edx,0x8(%ebp)
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	0f be c0             	movsbl %al,%eax
 292:	01 c8                	add    %ecx,%eax
 294:	83 e8 30             	sub    $0x30,%eax
 297:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
 29d:	0f b6 00             	movzbl (%eax),%eax
 2a0:	3c 2f                	cmp    $0x2f,%al
 2a2:	7e 0a                	jle    2ae <atoi+0x48>
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	0f b6 00             	movzbl (%eax),%eax
 2aa:	3c 39                	cmp    $0x39,%al
 2ac:	7e c7                	jle    275 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b1:	c9                   	leave  
 2b2:	c3                   	ret    

000002b3 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b3:	55                   	push   %ebp
 2b4:	89 e5                	mov    %esp,%ebp
 2b6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2c5:	eb 17                	jmp    2de <memmove+0x2b>
    *dst++ = *src++;
 2c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ca:	8d 50 01             	lea    0x1(%eax),%edx
 2cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2d3:	8d 4a 01             	lea    0x1(%edx),%ecx
 2d6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2d9:	0f b6 12             	movzbl (%edx),%edx
 2dc:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2de:	8b 45 10             	mov    0x10(%ebp),%eax
 2e1:	8d 50 ff             	lea    -0x1(%eax),%edx
 2e4:	89 55 10             	mov    %edx,0x10(%ebp)
 2e7:	85 c0                	test   %eax,%eax
 2e9:	7f dc                	jg     2c7 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ee:	c9                   	leave  
 2ef:	c3                   	ret    

000002f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2f0:	b8 01 00 00 00       	mov    $0x1,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <exit>:
SYSCALL(exit)
 2f8:	b8 02 00 00 00       	mov    $0x2,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <wait>:
SYSCALL(wait)
 300:	b8 03 00 00 00       	mov    $0x3,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <pipe>:
SYSCALL(pipe)
 308:	b8 04 00 00 00       	mov    $0x4,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <read>:
SYSCALL(read)
 310:	b8 05 00 00 00       	mov    $0x5,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <write>:
SYSCALL(write)
 318:	b8 10 00 00 00       	mov    $0x10,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <close>:
SYSCALL(close)
 320:	b8 15 00 00 00       	mov    $0x15,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <kill>:
SYSCALL(kill)
 328:	b8 06 00 00 00       	mov    $0x6,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <exec>:
SYSCALL(exec)
 330:	b8 07 00 00 00       	mov    $0x7,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <open>:
SYSCALL(open)
 338:	b8 0f 00 00 00       	mov    $0xf,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <mknod>:
SYSCALL(mknod)
 340:	b8 11 00 00 00       	mov    $0x11,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <unlink>:
SYSCALL(unlink)
 348:	b8 12 00 00 00       	mov    $0x12,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <fstat>:
SYSCALL(fstat)
 350:	b8 08 00 00 00       	mov    $0x8,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <link>:
SYSCALL(link)
 358:	b8 13 00 00 00       	mov    $0x13,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <mkdir>:
SYSCALL(mkdir)
 360:	b8 14 00 00 00       	mov    $0x14,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <chdir>:
SYSCALL(chdir)
 368:	b8 09 00 00 00       	mov    $0x9,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <dup>:
SYSCALL(dup)
 370:	b8 0a 00 00 00       	mov    $0xa,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <getpid>:
SYSCALL(getpid)
 378:	b8 0b 00 00 00       	mov    $0xb,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <sbrk>:
SYSCALL(sbrk)
 380:	b8 0c 00 00 00       	mov    $0xc,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <sleep>:
SYSCALL(sleep)
 388:	b8 0d 00 00 00       	mov    $0xd,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <uptime>:
SYSCALL(uptime)
 390:	b8 0e 00 00 00       	mov    $0xe,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <date>:
SYSCALL(date)
 398:	b8 16 00 00 00       	mov    $0x16,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <clone>:
SYSCALL(clone)
 3a0:	b8 17 00 00 00       	mov    $0x17,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <join>:
SYSCALL(join)
 3a8:	b8 18 00 00 00       	mov    $0x18,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <threadSleep>:
SYSCALL(threadSleep)
 3b0:	b8 19 00 00 00       	mov    $0x19,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <threadWake>:
SYSCALL(threadWake)
 3b8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 18             	sub    $0x18,%esp
 3c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d3:	00 
 3d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3db:	8b 45 08             	mov    0x8(%ebp),%eax
 3de:	89 04 24             	mov    %eax,(%esp)
 3e1:	e8 32 ff ff ff       	call   318 <write>
}
 3e6:	c9                   	leave  
 3e7:	c3                   	ret    

000003e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	56                   	push   %esi
 3ec:	53                   	push   %ebx
 3ed:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fb:	74 17                	je     414 <printint+0x2c>
 3fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 401:	79 11                	jns    414 <printint+0x2c>
    neg = 1;
 403:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 40a:	8b 45 0c             	mov    0xc(%ebp),%eax
 40d:	f7 d8                	neg    %eax
 40f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 412:	eb 06                	jmp    41a <printint+0x32>
  } else {
    x = xx;
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 41a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 421:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 424:	8d 41 01             	lea    0x1(%ecx),%eax
 427:	89 45 f4             	mov    %eax,-0xc(%ebp)
 42a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 42d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 430:	ba 00 00 00 00       	mov    $0x0,%edx
 435:	f7 f3                	div    %ebx
 437:	89 d0                	mov    %edx,%eax
 439:	0f b6 80 3c 0f 00 00 	movzbl 0xf3c(%eax),%eax
 440:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 444:	8b 75 10             	mov    0x10(%ebp),%esi
 447:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44a:	ba 00 00 00 00       	mov    $0x0,%edx
 44f:	f7 f6                	div    %esi
 451:	89 45 ec             	mov    %eax,-0x14(%ebp)
 454:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 458:	75 c7                	jne    421 <printint+0x39>
  if(neg)
 45a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45e:	74 10                	je     470 <printint+0x88>
    buf[i++] = '-';
 460:	8b 45 f4             	mov    -0xc(%ebp),%eax
 463:	8d 50 01             	lea    0x1(%eax),%edx
 466:	89 55 f4             	mov    %edx,-0xc(%ebp)
 469:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 46e:	eb 1f                	jmp    48f <printint+0xa7>
 470:	eb 1d                	jmp    48f <printint+0xa7>
    putc(fd, buf[i]);
 472:	8d 55 dc             	lea    -0x24(%ebp),%edx
 475:	8b 45 f4             	mov    -0xc(%ebp),%eax
 478:	01 d0                	add    %edx,%eax
 47a:	0f b6 00             	movzbl (%eax),%eax
 47d:	0f be c0             	movsbl %al,%eax
 480:	89 44 24 04          	mov    %eax,0x4(%esp)
 484:	8b 45 08             	mov    0x8(%ebp),%eax
 487:	89 04 24             	mov    %eax,(%esp)
 48a:	e8 31 ff ff ff       	call   3c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 48f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 493:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 497:	79 d9                	jns    472 <printint+0x8a>
    putc(fd, buf[i]);
}
 499:	83 c4 30             	add    $0x30,%esp
 49c:	5b                   	pop    %ebx
 49d:	5e                   	pop    %esi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4ad:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b0:	83 c0 04             	add    $0x4,%eax
 4b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4bd:	e9 7c 01 00 00       	jmp    63e <printf+0x19e>
    c = fmt[i] & 0xff;
 4c2:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c8:	01 d0                	add    %edx,%eax
 4ca:	0f b6 00             	movzbl (%eax),%eax
 4cd:	0f be c0             	movsbl %al,%eax
 4d0:	25 ff 00 00 00       	and    $0xff,%eax
 4d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4dc:	75 2c                	jne    50a <printf+0x6a>
      if(c == '%'){
 4de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e2:	75 0c                	jne    4f0 <printf+0x50>
        state = '%';
 4e4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4eb:	e9 4a 01 00 00       	jmp    63a <printf+0x19a>
      } else {
        putc(fd, c);
 4f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f3:	0f be c0             	movsbl %al,%eax
 4f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fa:	8b 45 08             	mov    0x8(%ebp),%eax
 4fd:	89 04 24             	mov    %eax,(%esp)
 500:	e8 bb fe ff ff       	call   3c0 <putc>
 505:	e9 30 01 00 00       	jmp    63a <printf+0x19a>
      }
    } else if(state == '%'){
 50a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 50e:	0f 85 26 01 00 00    	jne    63a <printf+0x19a>
      if(c == 'd'){
 514:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 518:	75 2d                	jne    547 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 51a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51d:	8b 00                	mov    (%eax),%eax
 51f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 526:	00 
 527:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 52e:	00 
 52f:	89 44 24 04          	mov    %eax,0x4(%esp)
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	89 04 24             	mov    %eax,(%esp)
 539:	e8 aa fe ff ff       	call   3e8 <printint>
        ap++;
 53e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 542:	e9 ec 00 00 00       	jmp    633 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 547:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54b:	74 06                	je     553 <printf+0xb3>
 54d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 551:	75 2d                	jne    580 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 553:	8b 45 e8             	mov    -0x18(%ebp),%eax
 556:	8b 00                	mov    (%eax),%eax
 558:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 55f:	00 
 560:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 567:	00 
 568:	89 44 24 04          	mov    %eax,0x4(%esp)
 56c:	8b 45 08             	mov    0x8(%ebp),%eax
 56f:	89 04 24             	mov    %eax,(%esp)
 572:	e8 71 fe ff ff       	call   3e8 <printint>
        ap++;
 577:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57b:	e9 b3 00 00 00       	jmp    633 <printf+0x193>
      } else if(c == 's'){
 580:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 584:	75 45                	jne    5cb <printf+0x12b>
        s = (char*)*ap;
 586:	8b 45 e8             	mov    -0x18(%ebp),%eax
 589:	8b 00                	mov    (%eax),%eax
 58b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 58e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 592:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 596:	75 09                	jne    5a1 <printf+0x101>
          s = "(null)";
 598:	c7 45 f4 41 0b 00 00 	movl   $0xb41,-0xc(%ebp)
        while(*s != 0){
 59f:	eb 1e                	jmp    5bf <printf+0x11f>
 5a1:	eb 1c                	jmp    5bf <printf+0x11f>
          putc(fd, *s);
 5a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a6:	0f b6 00             	movzbl (%eax),%eax
 5a9:	0f be c0             	movsbl %al,%eax
 5ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b0:	8b 45 08             	mov    0x8(%ebp),%eax
 5b3:	89 04 24             	mov    %eax,(%esp)
 5b6:	e8 05 fe ff ff       	call   3c0 <putc>
          s++;
 5bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c2:	0f b6 00             	movzbl (%eax),%eax
 5c5:	84 c0                	test   %al,%al
 5c7:	75 da                	jne    5a3 <printf+0x103>
 5c9:	eb 68                	jmp    633 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5cf:	75 1d                	jne    5ee <printf+0x14e>
        putc(fd, *ap);
 5d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	0f be c0             	movsbl %al,%eax
 5d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	89 04 24             	mov    %eax,(%esp)
 5e3:	e8 d8 fd ff ff       	call   3c0 <putc>
        ap++;
 5e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ec:	eb 45                	jmp    633 <printf+0x193>
      } else if(c == '%'){
 5ee:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f2:	75 17                	jne    60b <printf+0x16b>
        putc(fd, c);
 5f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f7:	0f be c0             	movsbl %al,%eax
 5fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	89 04 24             	mov    %eax,(%esp)
 604:	e8 b7 fd ff ff       	call   3c0 <putc>
 609:	eb 28                	jmp    633 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 612:	00 
 613:	8b 45 08             	mov    0x8(%ebp),%eax
 616:	89 04 24             	mov    %eax,(%esp)
 619:	e8 a2 fd ff ff       	call   3c0 <putc>
        putc(fd, c);
 61e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	89 44 24 04          	mov    %eax,0x4(%esp)
 628:	8b 45 08             	mov    0x8(%ebp),%eax
 62b:	89 04 24             	mov    %eax,(%esp)
 62e:	e8 8d fd ff ff       	call   3c0 <putc>
      }
      state = 0;
 633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 63e:	8b 55 0c             	mov    0xc(%ebp),%edx
 641:	8b 45 f0             	mov    -0x10(%ebp),%eax
 644:	01 d0                	add    %edx,%eax
 646:	0f b6 00             	movzbl (%eax),%eax
 649:	84 c0                	test   %al,%al
 64b:	0f 85 71 fe ff ff    	jne    4c2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 651:	c9                   	leave  
 652:	c3                   	ret    
 653:	90                   	nop

00000654 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 654:	55                   	push   %ebp
 655:	89 e5                	mov    %esp,%ebp
 657:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	83 e8 08             	sub    $0x8,%eax
 660:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 663:	a1 58 0f 00 00       	mov    0xf58,%eax
 668:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66b:	eb 24                	jmp    691 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 12                	ja     689 <free+0x35>
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	77 24                	ja     6a3 <free+0x4f>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	77 1a                	ja     6a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 697:	76 d4                	jbe    66d <free+0x19>
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a1:	76 ca                	jbe    66d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	01 c2                	add    %eax,%edx
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	39 c2                	cmp    %eax,%edx
 6bc:	75 24                	jne    6e2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	8b 50 04             	mov    0x4(%eax),%edx
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	8b 40 04             	mov    0x4(%eax),%eax
 6cc:	01 c2                	add    %eax,%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
 6e0:	eb 0a                	jmp    6ec <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 10                	mov    (%eax),%edx
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 40 04             	mov    0x4(%eax),%eax
 6f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	01 d0                	add    %edx,%eax
 6fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 701:	75 20                	jne    723 <free+0xcf>
    p->s.size += bp->s.size;
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	8b 50 04             	mov    0x4(%eax),%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	8b 40 04             	mov    0x4(%eax),%eax
 70f:	01 c2                	add    %eax,%edx
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	8b 10                	mov    (%eax),%edx
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	89 10                	mov    %edx,(%eax)
 721:	eb 08                	jmp    72b <free+0xd7>
  } else
    p->s.ptr = bp;
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	8b 55 f8             	mov    -0x8(%ebp),%edx
 729:	89 10                	mov    %edx,(%eax)
  freep = p;
 72b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72e:	a3 58 0f 00 00       	mov    %eax,0xf58
}
 733:	c9                   	leave  
 734:	c3                   	ret    

00000735 <morecore>:

static Header*
morecore(uint nu)
{
 735:	55                   	push   %ebp
 736:	89 e5                	mov    %esp,%ebp
 738:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 73b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 742:	77 07                	ja     74b <morecore+0x16>
    nu = 4096;
 744:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 74b:	8b 45 08             	mov    0x8(%ebp),%eax
 74e:	c1 e0 03             	shl    $0x3,%eax
 751:	89 04 24             	mov    %eax,(%esp)
 754:	e8 27 fc ff ff       	call   380 <sbrk>
 759:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 75c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 760:	75 07                	jne    769 <morecore+0x34>
    return 0;
 762:	b8 00 00 00 00       	mov    $0x0,%eax
 767:	eb 22                	jmp    78b <morecore+0x56>
  hp = (Header*)p;
 769:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 76f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 772:	8b 55 08             	mov    0x8(%ebp),%edx
 775:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	83 c0 08             	add    $0x8,%eax
 77e:	89 04 24             	mov    %eax,(%esp)
 781:	e8 ce fe ff ff       	call   654 <free>
  return freep;
 786:	a1 58 0f 00 00       	mov    0xf58,%eax
}
 78b:	c9                   	leave  
 78c:	c3                   	ret    

0000078d <malloc>:

void*
malloc(uint nbytes)
{
 78d:	55                   	push   %ebp
 78e:	89 e5                	mov    %esp,%ebp
 790:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 793:	8b 45 08             	mov    0x8(%ebp),%eax
 796:	83 c0 07             	add    $0x7,%eax
 799:	c1 e8 03             	shr    $0x3,%eax
 79c:	83 c0 01             	add    $0x1,%eax
 79f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7a2:	a1 58 0f 00 00       	mov    0xf58,%eax
 7a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7ae:	75 23                	jne    7d3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7b0:	c7 45 f0 50 0f 00 00 	movl   $0xf50,-0x10(%ebp)
 7b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ba:	a3 58 0f 00 00       	mov    %eax,0xf58
 7bf:	a1 58 0f 00 00       	mov    0xf58,%eax
 7c4:	a3 50 0f 00 00       	mov    %eax,0xf50
    base.s.size = 0;
 7c9:	c7 05 54 0f 00 00 00 	movl   $0x0,0xf54
 7d0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d6:	8b 00                	mov    (%eax),%eax
 7d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	8b 40 04             	mov    0x4(%eax),%eax
 7e1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e4:	72 4d                	jb     833 <malloc+0xa6>
      if(p->s.size == nunits)
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 40 04             	mov    0x4(%eax),%eax
 7ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ef:	75 0c                	jne    7fd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	8b 10                	mov    (%eax),%edx
 7f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f9:	89 10                	mov    %edx,(%eax)
 7fb:	eb 26                	jmp    823 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	2b 45 ec             	sub    -0x14(%ebp),%eax
 806:	89 c2                	mov    %eax,%edx
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	8b 40 04             	mov    0x4(%eax),%eax
 814:	c1 e0 03             	shl    $0x3,%eax
 817:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 820:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 823:	8b 45 f0             	mov    -0x10(%ebp),%eax
 826:	a3 58 0f 00 00       	mov    %eax,0xf58
      return (void*)(p + 1);
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	83 c0 08             	add    $0x8,%eax
 831:	eb 38                	jmp    86b <malloc+0xde>
    }
    if(p == freep)
 833:	a1 58 0f 00 00       	mov    0xf58,%eax
 838:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 83b:	75 1b                	jne    858 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 83d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 840:	89 04 24             	mov    %eax,(%esp)
 843:	e8 ed fe ff ff       	call   735 <morecore>
 848:	89 45 f4             	mov    %eax,-0xc(%ebp)
 84b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 84f:	75 07                	jne    858 <malloc+0xcb>
        return 0;
 851:	b8 00 00 00 00       	mov    $0x0,%eax
 856:	eb 13                	jmp    86b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 861:	8b 00                	mov    (%eax),%eax
 863:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 866:	e9 70 ff ff ff       	jmp    7db <malloc+0x4e>
}
 86b:	c9                   	leave  
 86c:	c3                   	ret    
 86d:	66 90                	xchg   %ax,%ax
 86f:	90                   	nop

00000870 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 876:	8b 55 08             	mov    0x8(%ebp),%edx
 879:	8b 45 0c             	mov    0xc(%ebp),%eax
 87c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 87f:	f0 87 02             	lock xchg %eax,(%edx)
 882:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 885:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 888:	c9                   	leave  
 889:	c3                   	ret    

0000088a <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 88a:	55                   	push   %ebp
 88b:	89 e5                	mov    %esp,%ebp
 88d:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 890:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 897:	e8 f1 fe ff ff       	call   78d <malloc>
 89c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	85 c0                	test   %eax,%eax
 8a4:	75 1b                	jne    8c1 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 8a6:	c7 44 24 04 48 0b 00 	movl   $0xb48,0x4(%esp)
 8ad:	00 
 8ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8b5:	e8 e6 fb ff ff       	call   4a0 <printf>
    return -1;
 8ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 8bf:	eb 43                	jmp    904 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c4:	25 ff 0f 00 00       	and    $0xfff,%eax
 8c9:	85 c0                	test   %eax,%eax
 8cb:	74 14                	je     8e1 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 8cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d0:	25 ff 0f 00 00       	and    $0xfff,%eax
 8d5:	89 c2                	mov    %eax,%edx
 8d7:	b8 00 10 00 00       	mov    $0x1000,%eax
 8dc:	29 d0                	sub    %edx,%eax
 8de:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 8e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e4:	89 44 24 08          	mov    %eax,0x8(%esp)
 8e8:	8b 45 14             	mov    0x14(%ebp),%eax
 8eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ef:	8b 45 10             	mov    0x10(%ebp),%eax
 8f2:	89 04 24             	mov    %eax,(%esp)
 8f5:	e8 a6 fa ff ff       	call   3a0 <clone>
 8fa:	8b 55 08             	mov    0x8(%ebp),%edx
 8fd:	89 02                	mov    %eax,(%edx)
  return *thread;
 8ff:	8b 45 08             	mov    0x8(%ebp),%eax
 902:	8b 00                	mov    (%eax),%eax
}
 904:	c9                   	leave  
 905:	c3                   	ret    

00000906 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 906:	55                   	push   %ebp
 907:	89 e5                	mov    %esp,%ebp
 909:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 90c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 90f:	89 44 24 04          	mov    %eax,0x4(%esp)
 913:	8b 45 08             	mov    0x8(%ebp),%eax
 916:	89 04 24             	mov    %eax,(%esp)
 919:	e8 8a fa ff ff       	call   3a8 <join>
 91e:	85 c0                	test   %eax,%eax
 920:	79 07                	jns    929 <pthread_join+0x23>
    return -1;
 922:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 927:	eb 10                	jmp    939 <pthread_join+0x33>
  }
  free(stack);
 929:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92c:	89 04 24             	mov    %eax,(%esp)
 92f:	e8 20 fd ff ff       	call   654 <free>
  return 0;
 934:	b8 00 00 00 00       	mov    $0x0,%eax
}
 939:	c9                   	leave  
 93a:	c3                   	ret    

0000093b <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 93b:	55                   	push   %ebp
 93c:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 93e:	8b 45 08             	mov    0x8(%ebp),%eax
 941:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 947:	90                   	nop
}
 948:	5d                   	pop    %ebp
 949:	c3                   	ret    

0000094a <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 94a:	55                   	push   %ebp
 94b:	89 e5                	mov    %esp,%ebp
 94d:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 950:	90                   	nop
 951:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 958:	00 
 959:	8b 45 08             	mov    0x8(%ebp),%eax
 95c:	89 04 24             	mov    %eax,(%esp)
 95f:	e8 0c ff ff ff       	call   870 <xchg>
 964:	85 c0                	test   %eax,%eax
 966:	75 e9                	jne    951 <pthread_mutex_lock+0x7>
  return;
 968:	90                   	nop
}
 969:	c9                   	leave  
 96a:	c3                   	ret    

0000096b <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 96b:	55                   	push   %ebp
 96c:	89 e5                	mov    %esp,%ebp
 96e:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 971:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 978:	00 
 979:	8b 45 08             	mov    0x8(%ebp),%eax
 97c:	89 04 24             	mov    %eax,(%esp)
 97f:	e8 ec fe ff ff       	call   870 <xchg>
  return;
 984:	90                   	nop
}
 985:	c9                   	leave  
 986:	c3                   	ret    

00000987 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 987:	55                   	push   %ebp
 988:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 98a:	8b 45 08             	mov    0x8(%ebp),%eax
 98d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 99d:	90                   	nop
}
 99e:	5d                   	pop    %ebp
 99f:	c3                   	ret    

000009a0 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	53                   	push   %ebx
 9a4:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 9a7:	8b 45 08             	mov    0x8(%ebp),%eax
 9aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 9ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 9b0:	89 04 24             	mov    %eax,(%esp)
 9b3:	e8 b3 ff ff ff       	call   96b <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 9b8:	eb 09                	jmp    9c3 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bd:	8b 40 04             	mov    0x4(%eax),%eax
 9c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 9c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c6:	8b 40 04             	mov    0x4(%eax),%eax
 9c9:	85 c0                	test   %eax,%eax
 9cb:	75 ed                	jne    9ba <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 9cd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 9d4:	e8 b4 fd ff ff       	call   78d <malloc>
 9d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9dc:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e2:	8b 58 04             	mov    0x4(%eax),%ebx
 9e5:	e8 8e f9 ff ff       	call   378 <getpid>
 9ea:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 9ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ef:	8b 40 04             	mov    0x4(%eax),%eax
 9f2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 9f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 9fc:	89 04 24             	mov    %eax,(%esp)
 9ff:	e8 46 ff ff ff       	call   94a <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 a04:	8b 45 0c             	mov    0xc(%ebp),%eax
 a07:	89 04 24             	mov    %eax,(%esp)
 a0a:	e8 5c ff ff ff       	call   96b <pthread_mutex_unlock>
  threadSleep(mutex);
 a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
 a12:	89 04 24             	mov    %eax,(%esp)
 a15:	e8 96 f9 ff ff       	call   3b0 <threadSleep>
  pthread_mutex_lock(mutex);
 a1a:	8b 45 0c             	mov    0xc(%ebp),%eax
 a1d:	89 04 24             	mov    %eax,(%esp)
 a20:	e8 25 ff ff ff       	call   94a <pthread_mutex_lock>
  return;
 a25:	90                   	nop
}
 a26:	83 c4 24             	add    $0x24,%esp
 a29:	5b                   	pop    %ebx
 a2a:	5d                   	pop    %ebp
 a2b:	c3                   	ret    

00000a2c <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 a2c:	55                   	push   %ebp
 a2d:	89 e5                	mov    %esp,%ebp
 a2f:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 a32:	8b 45 08             	mov    0x8(%ebp),%eax
 a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 a38:	eb 09                	jmp    a43 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3d:	8b 40 04             	mov    0x4(%eax),%eax
 a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a46:	8b 00                	mov    (%eax),%eax
 a48:	83 f8 ff             	cmp    $0xffffffff,%eax
 a4b:	74 ed                	je     a3a <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 a4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a51:	74 33                	je     a86 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a56:	8b 00                	mov    (%eax),%eax
 a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 a61:	8b 45 08             	mov    0x8(%ebp),%eax
 a64:	8b 40 04             	mov    0x4(%eax),%eax
 a67:	8b 50 04             	mov    0x4(%eax),%edx
 a6a:	8b 45 08             	mov    0x8(%ebp),%eax
 a6d:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 a70:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a73:	89 04 24             	mov    %eax,(%esp)
 a76:	e8 d9 fb ff ff       	call   654 <free>
    threadWake(threadId);
 a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a7e:	89 04 24             	mov    %eax,(%esp)
 a81:	e8 32 f9 ff ff       	call   3b8 <threadWake>
  }
  return;
 a86:	90                   	nop
}
 a87:	c9                   	leave  
 a88:	c3                   	ret    

00000a89 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 a89:	55                   	push   %ebp
 a8a:	89 e5                	mov    %esp,%ebp
 a8c:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 a8f:	8b 45 08             	mov    0x8(%ebp),%eax
 a92:	8b 55 10             	mov    0x10(%ebp),%edx
 a95:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 a97:	8b 45 08             	mov    0x8(%ebp),%eax
 a9a:	83 c0 04             	add    $0x4,%eax
 a9d:	89 04 24             	mov    %eax,(%esp)
 aa0:	e8 e2 fe ff ff       	call   987 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 aa5:	8b 45 08             	mov    0x8(%ebp),%eax
 aa8:	83 c0 0c             	add    $0xc,%eax
 aab:	89 04 24             	mov    %eax,(%esp)
 aae:	e8 88 fe ff ff       	call   93b <pthread_mutex_init>
  return;
 ab3:	90                   	nop
}
 ab4:	c9                   	leave  
 ab5:	c3                   	ret    

00000ab6 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 ab6:	55                   	push   %ebp
 ab7:	89 e5                	mov    %esp,%ebp
 ab9:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 abc:	8b 45 08             	mov    0x8(%ebp),%eax
 abf:	8b 00                	mov    (%eax),%eax
 ac1:	8d 50 ff             	lea    -0x1(%eax),%edx
 ac4:	8b 45 08             	mov    0x8(%ebp),%eax
 ac7:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 ac9:	8b 45 08             	mov    0x8(%ebp),%eax
 acc:	8b 00                	mov    (%eax),%eax
 ace:	85 c0                	test   %eax,%eax
 ad0:	79 18                	jns    aea <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 ad2:	8b 45 08             	mov    0x8(%ebp),%eax
 ad5:	8d 50 0c             	lea    0xc(%eax),%edx
 ad8:	8b 45 08             	mov    0x8(%ebp),%eax
 adb:	83 c0 04             	add    $0x4,%eax
 ade:	89 54 24 04          	mov    %edx,0x4(%esp)
 ae2:	89 04 24             	mov    %eax,(%esp)
 ae5:	e8 b6 fe ff ff       	call   9a0 <pthread_cond_wait>
  }
  return;
 aea:	90                   	nop
}
 aeb:	c9                   	leave  
 aec:	c3                   	ret    

00000aed <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 aed:	55                   	push   %ebp
 aee:	89 e5                	mov    %esp,%ebp
 af0:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 af3:	8b 45 08             	mov    0x8(%ebp),%eax
 af6:	8b 00                	mov    (%eax),%eax
 af8:	8d 50 01             	lea    0x1(%eax),%edx
 afb:	8b 45 08             	mov    0x8(%ebp),%eax
 afe:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 b00:	8b 45 08             	mov    0x8(%ebp),%eax
 b03:	83 c0 04             	add    $0x4,%eax
 b06:	89 04 24             	mov    %eax,(%esp)
 b09:	e8 1e ff ff ff       	call   a2c <pthread_cond_signal>
  return;
 b0e:	90                   	nop
}
 b0f:	c9                   	leave  
 b10:	c3                   	ret    
