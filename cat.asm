
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 1b                	jmp    23 <cat+0x23>
    write(1, buf, n);
   8:	8b 45 f4             	mov    -0xc(%ebp),%eax
   b:	89 44 24 08          	mov    %eax,0x8(%esp)
   f:	c7 44 24 04 20 10 00 	movl   $0x1020,0x4(%esp)
  16:	00 
  17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1e:	e8 85 03 00 00       	call   3a8 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 20 10 00 	movl   $0x1020,0x4(%esp)
  32:	00 
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 62 03 00 00       	call   3a0 <read>
  3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  45:	7f c1                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
  4d:	c7 44 24 04 a4 0b 00 	movl   $0xba4,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 cf 04 00 00       	call   530 <printf>
    exit();
  61:	e8 22 03 00 00       	call   388 <exit>
  }
}
  66:	c9                   	leave  
  67:	c3                   	ret    

00000068 <main>:

int
main(int argc, char *argv[])
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	83 e4 f0             	and    $0xfffffff0,%esp
  6e:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
  71:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  75:	7f 11                	jg     88 <main+0x20>
    cat(0);
  77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7e:	e8 7d ff ff ff       	call   0 <cat>
    exit();
  83:	e8 00 03 00 00       	call   388 <exit>
  }

  for(i = 1; i < argc; i++){
  88:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  8f:	00 
  90:	eb 79                	jmp    10b <main+0xa3>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  96:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  a0:	01 d0                	add    %edx,%eax
  a2:	8b 00                	mov    (%eax),%eax
  a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  ab:	00 
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 14 03 00 00       	call   3c8 <open>
  b4:	89 44 24 18          	mov    %eax,0x18(%esp)
  b8:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  bd:	79 2f                	jns    ee <main+0x86>
      printf(1, "cat: cannot open %s\n", argv[i]);
  bf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	01 d0                	add    %edx,%eax
  cf:	8b 00                	mov    (%eax),%eax
  d1:	89 44 24 08          	mov    %eax,0x8(%esp)
  d5:	c7 44 24 04 b5 0b 00 	movl   $0xbb5,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e4:	e8 47 04 00 00       	call   530 <printf>
      exit();
  e9:	e8 9a 02 00 00       	call   388 <exit>
    }
    cat(fd);
  ee:	8b 44 24 18          	mov    0x18(%esp),%eax
  f2:	89 04 24             	mov    %eax,(%esp)
  f5:	e8 06 ff ff ff       	call   0 <cat>
    close(fd);
  fa:	8b 44 24 18          	mov    0x18(%esp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 aa 02 00 00       	call   3b0 <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
 106:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 10b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 10f:	3b 45 08             	cmp    0x8(%ebp),%eax
 112:	0f 8c 7a ff ff ff    	jl     92 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 118:	e8 6b 02 00 00       	call   388 <exit>
 11d:	66 90                	xchg   %ax,%ax
 11f:	90                   	nop

00000120 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 125:	8b 4d 08             	mov    0x8(%ebp),%ecx
 128:	8b 55 10             	mov    0x10(%ebp),%edx
 12b:	8b 45 0c             	mov    0xc(%ebp),%eax
 12e:	89 cb                	mov    %ecx,%ebx
 130:	89 df                	mov    %ebx,%edi
 132:	89 d1                	mov    %edx,%ecx
 134:	fc                   	cld    
 135:	f3 aa                	rep stos %al,%es:(%edi)
 137:	89 ca                	mov    %ecx,%edx
 139:	89 fb                	mov    %edi,%ebx
 13b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 141:	5b                   	pop    %ebx
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    

00000145 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
 148:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14b:	8b 45 08             	mov    0x8(%ebp),%eax
 14e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 151:	90                   	nop
 152:	8b 45 08             	mov    0x8(%ebp),%eax
 155:	8d 50 01             	lea    0x1(%eax),%edx
 158:	89 55 08             	mov    %edx,0x8(%ebp)
 15b:	8b 55 0c             	mov    0xc(%ebp),%edx
 15e:	8d 4a 01             	lea    0x1(%edx),%ecx
 161:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 164:	0f b6 12             	movzbl (%edx),%edx
 167:	88 10                	mov    %dl,(%eax)
 169:	0f b6 00             	movzbl (%eax),%eax
 16c:	84 c0                	test   %al,%al
 16e:	75 e2                	jne    152 <strcpy+0xd>
    ;
  return os;
 170:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 173:	c9                   	leave  
 174:	c3                   	ret    

00000175 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 175:	55                   	push   %ebp
 176:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 178:	eb 08                	jmp    182 <strcmp+0xd>
    p++, q++;
 17a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	84 c0                	test   %al,%al
 18a:	74 10                	je     19c <strcmp+0x27>
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 10             	movzbl (%eax),%edx
 192:	8b 45 0c             	mov    0xc(%ebp),%eax
 195:	0f b6 00             	movzbl (%eax),%eax
 198:	38 c2                	cmp    %al,%dl
 19a:	74 de                	je     17a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	0f b6 00             	movzbl (%eax),%eax
 1a2:	0f b6 d0             	movzbl %al,%edx
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	0f b6 00             	movzbl (%eax),%eax
 1ab:	0f b6 c0             	movzbl %al,%eax
 1ae:	29 c2                	sub    %eax,%edx
 1b0:	89 d0                	mov    %edx,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    

000001b4 <strlen>:

uint
strlen(char *s)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c1:	eb 04                	jmp    1c7 <strlen+0x13>
 1c3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	01 d0                	add    %edx,%eax
 1cf:	0f b6 00             	movzbl (%eax),%eax
 1d2:	84 c0                	test   %al,%al
 1d4:	75 ed                	jne    1c3 <strlen+0xf>
    ;
  return n;
 1d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d9:	c9                   	leave  
 1da:	c3                   	ret    

000001db <memset>:

void*
memset(void *dst, int c, uint n)
{
 1db:	55                   	push   %ebp
 1dc:	89 e5                	mov    %esp,%ebp
 1de:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1e1:	8b 45 10             	mov    0x10(%ebp),%eax
 1e4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	89 04 24             	mov    %eax,(%esp)
 1f5:	e8 26 ff ff ff       	call   120 <stosb>
  return dst;
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fd:	c9                   	leave  
 1fe:	c3                   	ret    

000001ff <strchr>:

char*
strchr(const char *s, char c)
{
 1ff:	55                   	push   %ebp
 200:	89 e5                	mov    %esp,%ebp
 202:	83 ec 04             	sub    $0x4,%esp
 205:	8b 45 0c             	mov    0xc(%ebp),%eax
 208:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20b:	eb 14                	jmp    221 <strchr+0x22>
    if(*s == c)
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	0f b6 00             	movzbl (%eax),%eax
 213:	3a 45 fc             	cmp    -0x4(%ebp),%al
 216:	75 05                	jne    21d <strchr+0x1e>
      return (char*)s;
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	eb 13                	jmp    230 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 21d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 221:	8b 45 08             	mov    0x8(%ebp),%eax
 224:	0f b6 00             	movzbl (%eax),%eax
 227:	84 c0                	test   %al,%al
 229:	75 e2                	jne    20d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 22b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 230:	c9                   	leave  
 231:	c3                   	ret    

00000232 <gets>:

char*
gets(char *buf, int max)
{
 232:	55                   	push   %ebp
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 23f:	eb 4c                	jmp    28d <gets+0x5b>
    cc = read(0, &c, 1);
 241:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 248:	00 
 249:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24c:	89 44 24 04          	mov    %eax,0x4(%esp)
 250:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 257:	e8 44 01 00 00       	call   3a0 <read>
 25c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 25f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 263:	7f 02                	jg     267 <gets+0x35>
      break;
 265:	eb 31                	jmp    298 <gets+0x66>
    buf[i++] = c;
 267:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26a:	8d 50 01             	lea    0x1(%eax),%edx
 26d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 270:	89 c2                	mov    %eax,%edx
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	01 c2                	add    %eax,%edx
 277:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 27d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 281:	3c 0a                	cmp    $0xa,%al
 283:	74 13                	je     298 <gets+0x66>
 285:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 289:	3c 0d                	cmp    $0xd,%al
 28b:	74 0b                	je     298 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 290:	83 c0 01             	add    $0x1,%eax
 293:	3b 45 0c             	cmp    0xc(%ebp),%eax
 296:	7c a9                	jl     241 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 298:	8b 55 f4             	mov    -0xc(%ebp),%edx
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	01 d0                	add    %edx,%eax
 2a0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a6:	c9                   	leave  
 2a7:	c3                   	ret    

000002a8 <stat>:

int
stat(char *n, struct stat *st)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b5:	00 
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	89 04 24             	mov    %eax,(%esp)
 2bc:	e8 07 01 00 00       	call   3c8 <open>
 2c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c8:	79 07                	jns    2d1 <stat+0x29>
    return -1;
 2ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2cf:	eb 23                	jmp    2f4 <stat+0x4c>
  r = fstat(fd, st);
 2d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2db:	89 04 24             	mov    %eax,(%esp)
 2de:	e8 fd 00 00 00       	call   3e0 <fstat>
 2e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e9:	89 04 24             	mov    %eax,(%esp)
 2ec:	e8 bf 00 00 00       	call   3b0 <close>
  return r;
 2f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2f4:	c9                   	leave  
 2f5:	c3                   	ret    

000002f6 <atoi>:

int
atoi(const char *s)
{
 2f6:	55                   	push   %ebp
 2f7:	89 e5                	mov    %esp,%ebp
 2f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 303:	eb 25                	jmp    32a <atoi+0x34>
    n = n*10 + *s++ - '0';
 305:	8b 55 fc             	mov    -0x4(%ebp),%edx
 308:	89 d0                	mov    %edx,%eax
 30a:	c1 e0 02             	shl    $0x2,%eax
 30d:	01 d0                	add    %edx,%eax
 30f:	01 c0                	add    %eax,%eax
 311:	89 c1                	mov    %eax,%ecx
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	8d 50 01             	lea    0x1(%eax),%edx
 319:	89 55 08             	mov    %edx,0x8(%ebp)
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	0f be c0             	movsbl %al,%eax
 322:	01 c8                	add    %ecx,%eax
 324:	83 e8 30             	sub    $0x30,%eax
 327:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32a:	8b 45 08             	mov    0x8(%ebp),%eax
 32d:	0f b6 00             	movzbl (%eax),%eax
 330:	3c 2f                	cmp    $0x2f,%al
 332:	7e 0a                	jle    33e <atoi+0x48>
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	0f b6 00             	movzbl (%eax),%eax
 33a:	3c 39                	cmp    $0x39,%al
 33c:	7e c7                	jle    305 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 33e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 341:	c9                   	leave  
 342:	c3                   	ret    

00000343 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 343:	55                   	push   %ebp
 344:	89 e5                	mov    %esp,%ebp
 346:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 34f:	8b 45 0c             	mov    0xc(%ebp),%eax
 352:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 355:	eb 17                	jmp    36e <memmove+0x2b>
    *dst++ = *src++;
 357:	8b 45 fc             	mov    -0x4(%ebp),%eax
 35a:	8d 50 01             	lea    0x1(%eax),%edx
 35d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 360:	8b 55 f8             	mov    -0x8(%ebp),%edx
 363:	8d 4a 01             	lea    0x1(%edx),%ecx
 366:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 369:	0f b6 12             	movzbl (%edx),%edx
 36c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	8b 45 10             	mov    0x10(%ebp),%eax
 371:	8d 50 ff             	lea    -0x1(%eax),%edx
 374:	89 55 10             	mov    %edx,0x10(%ebp)
 377:	85 c0                	test   %eax,%eax
 379:	7f dc                	jg     357 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 37e:	c9                   	leave  
 37f:	c3                   	ret    

00000380 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 380:	b8 01 00 00 00       	mov    $0x1,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <exit>:
SYSCALL(exit)
 388:	b8 02 00 00 00       	mov    $0x2,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <wait>:
SYSCALL(wait)
 390:	b8 03 00 00 00       	mov    $0x3,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <pipe>:
SYSCALL(pipe)
 398:	b8 04 00 00 00       	mov    $0x4,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <read>:
SYSCALL(read)
 3a0:	b8 05 00 00 00       	mov    $0x5,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <write>:
SYSCALL(write)
 3a8:	b8 10 00 00 00       	mov    $0x10,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <close>:
SYSCALL(close)
 3b0:	b8 15 00 00 00       	mov    $0x15,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <kill>:
SYSCALL(kill)
 3b8:	b8 06 00 00 00       	mov    $0x6,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <exec>:
SYSCALL(exec)
 3c0:	b8 07 00 00 00       	mov    $0x7,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <open>:
SYSCALL(open)
 3c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mknod>:
SYSCALL(mknod)
 3d0:	b8 11 00 00 00       	mov    $0x11,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <unlink>:
SYSCALL(unlink)
 3d8:	b8 12 00 00 00       	mov    $0x12,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <fstat>:
SYSCALL(fstat)
 3e0:	b8 08 00 00 00       	mov    $0x8,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <link>:
SYSCALL(link)
 3e8:	b8 13 00 00 00       	mov    $0x13,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <mkdir>:
SYSCALL(mkdir)
 3f0:	b8 14 00 00 00       	mov    $0x14,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <chdir>:
SYSCALL(chdir)
 3f8:	b8 09 00 00 00       	mov    $0x9,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <dup>:
SYSCALL(dup)
 400:	b8 0a 00 00 00       	mov    $0xa,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <getpid>:
SYSCALL(getpid)
 408:	b8 0b 00 00 00       	mov    $0xb,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <sbrk>:
SYSCALL(sbrk)
 410:	b8 0c 00 00 00       	mov    $0xc,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <sleep>:
SYSCALL(sleep)
 418:	b8 0d 00 00 00       	mov    $0xd,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <uptime>:
SYSCALL(uptime)
 420:	b8 0e 00 00 00       	mov    $0xe,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <date>:
SYSCALL(date)
 428:	b8 16 00 00 00       	mov    $0x16,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <clone>:
SYSCALL(clone)
 430:	b8 17 00 00 00       	mov    $0x17,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <join>:
SYSCALL(join)
 438:	b8 18 00 00 00       	mov    $0x18,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <threadSleep>:
SYSCALL(threadSleep)
 440:	b8 19 00 00 00       	mov    $0x19,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <threadWake>:
SYSCALL(threadWake)
 448:	b8 1a 00 00 00       	mov    $0x1a,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	83 ec 18             	sub    $0x18,%esp
 456:	8b 45 0c             	mov    0xc(%ebp),%eax
 459:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 45c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 463:	00 
 464:	8d 45 f4             	lea    -0xc(%ebp),%eax
 467:	89 44 24 04          	mov    %eax,0x4(%esp)
 46b:	8b 45 08             	mov    0x8(%ebp),%eax
 46e:	89 04 24             	mov    %eax,(%esp)
 471:	e8 32 ff ff ff       	call   3a8 <write>
}
 476:	c9                   	leave  
 477:	c3                   	ret    

00000478 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 478:	55                   	push   %ebp
 479:	89 e5                	mov    %esp,%ebp
 47b:	56                   	push   %esi
 47c:	53                   	push   %ebx
 47d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 480:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 487:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 48b:	74 17                	je     4a4 <printint+0x2c>
 48d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 491:	79 11                	jns    4a4 <printint+0x2c>
    neg = 1;
 493:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 49a:	8b 45 0c             	mov    0xc(%ebp),%eax
 49d:	f7 d8                	neg    %eax
 49f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a2:	eb 06                	jmp    4aa <printint+0x32>
  } else {
    x = xx;
 4a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4b4:	8d 41 01             	lea    0x1(%ecx),%eax
 4b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4c0:	ba 00 00 00 00       	mov    $0x0,%edx
 4c5:	f7 f3                	div    %ebx
 4c7:	89 d0                	mov    %edx,%eax
 4c9:	0f b6 80 e8 0f 00 00 	movzbl 0xfe8(%eax),%eax
 4d0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4d4:	8b 75 10             	mov    0x10(%ebp),%esi
 4d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4da:	ba 00 00 00 00       	mov    $0x0,%edx
 4df:	f7 f6                	div    %esi
 4e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e8:	75 c7                	jne    4b1 <printint+0x39>
  if(neg)
 4ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4ee:	74 10                	je     500 <printint+0x88>
    buf[i++] = '-';
 4f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f3:	8d 50 01             	lea    0x1(%eax),%edx
 4f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4f9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4fe:	eb 1f                	jmp    51f <printint+0xa7>
 500:	eb 1d                	jmp    51f <printint+0xa7>
    putc(fd, buf[i]);
 502:	8d 55 dc             	lea    -0x24(%ebp),%edx
 505:	8b 45 f4             	mov    -0xc(%ebp),%eax
 508:	01 d0                	add    %edx,%eax
 50a:	0f b6 00             	movzbl (%eax),%eax
 50d:	0f be c0             	movsbl %al,%eax
 510:	89 44 24 04          	mov    %eax,0x4(%esp)
 514:	8b 45 08             	mov    0x8(%ebp),%eax
 517:	89 04 24             	mov    %eax,(%esp)
 51a:	e8 31 ff ff ff       	call   450 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 51f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 523:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 527:	79 d9                	jns    502 <printint+0x8a>
    putc(fd, buf[i]);
}
 529:	83 c4 30             	add    $0x30,%esp
 52c:	5b                   	pop    %ebx
 52d:	5e                   	pop    %esi
 52e:	5d                   	pop    %ebp
 52f:	c3                   	ret    

00000530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 536:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 53d:	8d 45 0c             	lea    0xc(%ebp),%eax
 540:	83 c0 04             	add    $0x4,%eax
 543:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 546:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 54d:	e9 7c 01 00 00       	jmp    6ce <printf+0x19e>
    c = fmt[i] & 0xff;
 552:	8b 55 0c             	mov    0xc(%ebp),%edx
 555:	8b 45 f0             	mov    -0x10(%ebp),%eax
 558:	01 d0                	add    %edx,%eax
 55a:	0f b6 00             	movzbl (%eax),%eax
 55d:	0f be c0             	movsbl %al,%eax
 560:	25 ff 00 00 00       	and    $0xff,%eax
 565:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 568:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 56c:	75 2c                	jne    59a <printf+0x6a>
      if(c == '%'){
 56e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 572:	75 0c                	jne    580 <printf+0x50>
        state = '%';
 574:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 57b:	e9 4a 01 00 00       	jmp    6ca <printf+0x19a>
      } else {
        putc(fd, c);
 580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 583:	0f be c0             	movsbl %al,%eax
 586:	89 44 24 04          	mov    %eax,0x4(%esp)
 58a:	8b 45 08             	mov    0x8(%ebp),%eax
 58d:	89 04 24             	mov    %eax,(%esp)
 590:	e8 bb fe ff ff       	call   450 <putc>
 595:	e9 30 01 00 00       	jmp    6ca <printf+0x19a>
      }
    } else if(state == '%'){
 59a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 59e:	0f 85 26 01 00 00    	jne    6ca <printf+0x19a>
      if(c == 'd'){
 5a4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5a8:	75 2d                	jne    5d7 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ad:	8b 00                	mov    (%eax),%eax
 5af:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5b6:	00 
 5b7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5be:	00 
 5bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c3:	8b 45 08             	mov    0x8(%ebp),%eax
 5c6:	89 04 24             	mov    %eax,(%esp)
 5c9:	e8 aa fe ff ff       	call   478 <printint>
        ap++;
 5ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d2:	e9 ec 00 00 00       	jmp    6c3 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5db:	74 06                	je     5e3 <printf+0xb3>
 5dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5e1:	75 2d                	jne    610 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e6:	8b 00                	mov    (%eax),%eax
 5e8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5ef:	00 
 5f0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5f7:	00 
 5f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fc:	8b 45 08             	mov    0x8(%ebp),%eax
 5ff:	89 04 24             	mov    %eax,(%esp)
 602:	e8 71 fe ff ff       	call   478 <printint>
        ap++;
 607:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60b:	e9 b3 00 00 00       	jmp    6c3 <printf+0x193>
      } else if(c == 's'){
 610:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 614:	75 45                	jne    65b <printf+0x12b>
        s = (char*)*ap;
 616:	8b 45 e8             	mov    -0x18(%ebp),%eax
 619:	8b 00                	mov    (%eax),%eax
 61b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 61e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 622:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 626:	75 09                	jne    631 <printf+0x101>
          s = "(null)";
 628:	c7 45 f4 ca 0b 00 00 	movl   $0xbca,-0xc(%ebp)
        while(*s != 0){
 62f:	eb 1e                	jmp    64f <printf+0x11f>
 631:	eb 1c                	jmp    64f <printf+0x11f>
          putc(fd, *s);
 633:	8b 45 f4             	mov    -0xc(%ebp),%eax
 636:	0f b6 00             	movzbl (%eax),%eax
 639:	0f be c0             	movsbl %al,%eax
 63c:	89 44 24 04          	mov    %eax,0x4(%esp)
 640:	8b 45 08             	mov    0x8(%ebp),%eax
 643:	89 04 24             	mov    %eax,(%esp)
 646:	e8 05 fe ff ff       	call   450 <putc>
          s++;
 64b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 64f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 652:	0f b6 00             	movzbl (%eax),%eax
 655:	84 c0                	test   %al,%al
 657:	75 da                	jne    633 <printf+0x103>
 659:	eb 68                	jmp    6c3 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 65f:	75 1d                	jne    67e <printf+0x14e>
        putc(fd, *ap);
 661:	8b 45 e8             	mov    -0x18(%ebp),%eax
 664:	8b 00                	mov    (%eax),%eax
 666:	0f be c0             	movsbl %al,%eax
 669:	89 44 24 04          	mov    %eax,0x4(%esp)
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
 670:	89 04 24             	mov    %eax,(%esp)
 673:	e8 d8 fd ff ff       	call   450 <putc>
        ap++;
 678:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 67c:	eb 45                	jmp    6c3 <printf+0x193>
      } else if(c == '%'){
 67e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 682:	75 17                	jne    69b <printf+0x16b>
        putc(fd, c);
 684:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 687:	0f be c0             	movsbl %al,%eax
 68a:	89 44 24 04          	mov    %eax,0x4(%esp)
 68e:	8b 45 08             	mov    0x8(%ebp),%eax
 691:	89 04 24             	mov    %eax,(%esp)
 694:	e8 b7 fd ff ff       	call   450 <putc>
 699:	eb 28                	jmp    6c3 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 69b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6a2:	00 
 6a3:	8b 45 08             	mov    0x8(%ebp),%eax
 6a6:	89 04 24             	mov    %eax,(%esp)
 6a9:	e8 a2 fd ff ff       	call   450 <putc>
        putc(fd, c);
 6ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b1:	0f be c0             	movsbl %al,%eax
 6b4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b8:	8b 45 08             	mov    0x8(%ebp),%eax
 6bb:	89 04 24             	mov    %eax,(%esp)
 6be:	e8 8d fd ff ff       	call   450 <putc>
      }
      state = 0;
 6c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ca:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ce:	8b 55 0c             	mov    0xc(%ebp),%edx
 6d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d4:	01 d0                	add    %edx,%eax
 6d6:	0f b6 00             	movzbl (%eax),%eax
 6d9:	84 c0                	test   %al,%al
 6db:	0f 85 71 fe ff ff    	jne    552 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6e1:	c9                   	leave  
 6e2:	c3                   	ret    
 6e3:	90                   	nop

000006e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e4:	55                   	push   %ebp
 6e5:	89 e5                	mov    %esp,%ebp
 6e7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ea:	8b 45 08             	mov    0x8(%ebp),%eax
 6ed:	83 e8 08             	sub    $0x8,%eax
 6f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f3:	a1 08 10 00 00       	mov    0x1008,%eax
 6f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6fb:	eb 24                	jmp    721 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 00                	mov    (%eax),%eax
 702:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 705:	77 12                	ja     719 <free+0x35>
 707:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 70d:	77 24                	ja     733 <free+0x4f>
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	8b 00                	mov    (%eax),%eax
 714:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 717:	77 1a                	ja     733 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 00                	mov    (%eax),%eax
 71e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 721:	8b 45 f8             	mov    -0x8(%ebp),%eax
 724:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 727:	76 d4                	jbe    6fd <free+0x19>
 729:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72c:	8b 00                	mov    (%eax),%eax
 72e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 731:	76 ca                	jbe    6fd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 733:	8b 45 f8             	mov    -0x8(%ebp),%eax
 736:	8b 40 04             	mov    0x4(%eax),%eax
 739:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 740:	8b 45 f8             	mov    -0x8(%ebp),%eax
 743:	01 c2                	add    %eax,%edx
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	8b 00                	mov    (%eax),%eax
 74a:	39 c2                	cmp    %eax,%edx
 74c:	75 24                	jne    772 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 74e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 751:	8b 50 04             	mov    0x4(%eax),%edx
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 00                	mov    (%eax),%eax
 759:	8b 40 04             	mov    0x4(%eax),%eax
 75c:	01 c2                	add    %eax,%edx
 75e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 761:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 764:	8b 45 fc             	mov    -0x4(%ebp),%eax
 767:	8b 00                	mov    (%eax),%eax
 769:	8b 10                	mov    (%eax),%edx
 76b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76e:	89 10                	mov    %edx,(%eax)
 770:	eb 0a                	jmp    77c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 772:	8b 45 fc             	mov    -0x4(%ebp),%eax
 775:	8b 10                	mov    (%eax),%edx
 777:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 77c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77f:	8b 40 04             	mov    0x4(%eax),%eax
 782:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 789:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78c:	01 d0                	add    %edx,%eax
 78e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 791:	75 20                	jne    7b3 <free+0xcf>
    p->s.size += bp->s.size;
 793:	8b 45 fc             	mov    -0x4(%ebp),%eax
 796:	8b 50 04             	mov    0x4(%eax),%edx
 799:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79c:	8b 40 04             	mov    0x4(%eax),%eax
 79f:	01 c2                	add    %eax,%edx
 7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7aa:	8b 10                	mov    (%eax),%edx
 7ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7af:	89 10                	mov    %edx,(%eax)
 7b1:	eb 08                	jmp    7bb <free+0xd7>
  } else
    p->s.ptr = bp;
 7b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7b9:	89 10                	mov    %edx,(%eax)
  freep = p;
 7bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7be:	a3 08 10 00 00       	mov    %eax,0x1008
}
 7c3:	c9                   	leave  
 7c4:	c3                   	ret    

000007c5 <morecore>:

static Header*
morecore(uint nu)
{
 7c5:	55                   	push   %ebp
 7c6:	89 e5                	mov    %esp,%ebp
 7c8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7cb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7d2:	77 07                	ja     7db <morecore+0x16>
    nu = 4096;
 7d4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7db:	8b 45 08             	mov    0x8(%ebp),%eax
 7de:	c1 e0 03             	shl    $0x3,%eax
 7e1:	89 04 24             	mov    %eax,(%esp)
 7e4:	e8 27 fc ff ff       	call   410 <sbrk>
 7e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7ec:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7f0:	75 07                	jne    7f9 <morecore+0x34>
    return 0;
 7f2:	b8 00 00 00 00       	mov    $0x0,%eax
 7f7:	eb 22                	jmp    81b <morecore+0x56>
  hp = (Header*)p;
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 802:	8b 55 08             	mov    0x8(%ebp),%edx
 805:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 808:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80b:	83 c0 08             	add    $0x8,%eax
 80e:	89 04 24             	mov    %eax,(%esp)
 811:	e8 ce fe ff ff       	call   6e4 <free>
  return freep;
 816:	a1 08 10 00 00       	mov    0x1008,%eax
}
 81b:	c9                   	leave  
 81c:	c3                   	ret    

0000081d <malloc>:

void*
malloc(uint nbytes)
{
 81d:	55                   	push   %ebp
 81e:	89 e5                	mov    %esp,%ebp
 820:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 823:	8b 45 08             	mov    0x8(%ebp),%eax
 826:	83 c0 07             	add    $0x7,%eax
 829:	c1 e8 03             	shr    $0x3,%eax
 82c:	83 c0 01             	add    $0x1,%eax
 82f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 832:	a1 08 10 00 00       	mov    0x1008,%eax
 837:	89 45 f0             	mov    %eax,-0x10(%ebp)
 83a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 83e:	75 23                	jne    863 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 840:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
 847:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84a:	a3 08 10 00 00       	mov    %eax,0x1008
 84f:	a1 08 10 00 00       	mov    0x1008,%eax
 854:	a3 00 10 00 00       	mov    %eax,0x1000
    base.s.size = 0;
 859:	c7 05 04 10 00 00 00 	movl   $0x0,0x1004
 860:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 863:	8b 45 f0             	mov    -0x10(%ebp),%eax
 866:	8b 00                	mov    (%eax),%eax
 868:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86e:	8b 40 04             	mov    0x4(%eax),%eax
 871:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 874:	72 4d                	jb     8c3 <malloc+0xa6>
      if(p->s.size == nunits)
 876:	8b 45 f4             	mov    -0xc(%ebp),%eax
 879:	8b 40 04             	mov    0x4(%eax),%eax
 87c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 87f:	75 0c                	jne    88d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 881:	8b 45 f4             	mov    -0xc(%ebp),%eax
 884:	8b 10                	mov    (%eax),%edx
 886:	8b 45 f0             	mov    -0x10(%ebp),%eax
 889:	89 10                	mov    %edx,(%eax)
 88b:	eb 26                	jmp    8b3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 88d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 890:	8b 40 04             	mov    0x4(%eax),%eax
 893:	2b 45 ec             	sub    -0x14(%ebp),%eax
 896:	89 c2                	mov    %eax,%edx
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a1:	8b 40 04             	mov    0x4(%eax),%eax
 8a4:	c1 e0 03             	shl    $0x3,%eax
 8a7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8b0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b6:	a3 08 10 00 00       	mov    %eax,0x1008
      return (void*)(p + 1);
 8bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8be:	83 c0 08             	add    $0x8,%eax
 8c1:	eb 38                	jmp    8fb <malloc+0xde>
    }
    if(p == freep)
 8c3:	a1 08 10 00 00       	mov    0x1008,%eax
 8c8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8cb:	75 1b                	jne    8e8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8d0:	89 04 24             	mov    %eax,(%esp)
 8d3:	e8 ed fe ff ff       	call   7c5 <morecore>
 8d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8df:	75 07                	jne    8e8 <malloc+0xcb>
        return 0;
 8e1:	b8 00 00 00 00       	mov    $0x0,%eax
 8e6:	eb 13                	jmp    8fb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f1:	8b 00                	mov    (%eax),%eax
 8f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8f6:	e9 70 ff ff ff       	jmp    86b <malloc+0x4e>
}
 8fb:	c9                   	leave  
 8fc:	c3                   	ret    
 8fd:	66 90                	xchg   %ax,%ax
 8ff:	90                   	nop

00000900 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 906:	8b 55 08             	mov    0x8(%ebp),%edx
 909:	8b 45 0c             	mov    0xc(%ebp),%eax
 90c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 90f:	f0 87 02             	lock xchg %eax,(%edx)
 912:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 915:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 918:	c9                   	leave  
 919:	c3                   	ret    

0000091a <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 91a:	55                   	push   %ebp
 91b:	89 e5                	mov    %esp,%ebp
 91d:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 920:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 927:	e8 f1 fe ff ff       	call   81d <malloc>
 92c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 92f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 932:	85 c0                	test   %eax,%eax
 934:	75 1b                	jne    951 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 936:	c7 44 24 04 d4 0b 00 	movl   $0xbd4,0x4(%esp)
 93d:	00 
 93e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 945:	e8 e6 fb ff ff       	call   530 <printf>
    return -1;
 94a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 94f:	eb 43                	jmp    994 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 951:	8b 45 f4             	mov    -0xc(%ebp),%eax
 954:	25 ff 0f 00 00       	and    $0xfff,%eax
 959:	85 c0                	test   %eax,%eax
 95b:	74 14                	je     971 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 95d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 960:	25 ff 0f 00 00       	and    $0xfff,%eax
 965:	89 c2                	mov    %eax,%edx
 967:	b8 00 10 00 00       	mov    $0x1000,%eax
 96c:	29 d0                	sub    %edx,%eax
 96e:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 971:	8b 45 f4             	mov    -0xc(%ebp),%eax
 974:	89 44 24 08          	mov    %eax,0x8(%esp)
 978:	8b 45 14             	mov    0x14(%ebp),%eax
 97b:	89 44 24 04          	mov    %eax,0x4(%esp)
 97f:	8b 45 10             	mov    0x10(%ebp),%eax
 982:	89 04 24             	mov    %eax,(%esp)
 985:	e8 a6 fa ff ff       	call   430 <clone>
 98a:	8b 55 08             	mov    0x8(%ebp),%edx
 98d:	89 02                	mov    %eax,(%edx)
  return *thread;
 98f:	8b 45 08             	mov    0x8(%ebp),%eax
 992:	8b 00                	mov    (%eax),%eax
}
 994:	c9                   	leave  
 995:	c3                   	ret    

00000996 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 996:	55                   	push   %ebp
 997:	89 e5                	mov    %esp,%ebp
 999:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 99c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 99f:	89 44 24 04          	mov    %eax,0x4(%esp)
 9a3:	8b 45 08             	mov    0x8(%ebp),%eax
 9a6:	89 04 24             	mov    %eax,(%esp)
 9a9:	e8 8a fa ff ff       	call   438 <join>
 9ae:	85 c0                	test   %eax,%eax
 9b0:	79 07                	jns    9b9 <pthread_join+0x23>
    return -1;
 9b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9b7:	eb 10                	jmp    9c9 <pthread_join+0x33>
  }
  free(stack);
 9b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bc:	89 04 24             	mov    %eax,(%esp)
 9bf:	e8 20 fd ff ff       	call   6e4 <free>
  return 0;
 9c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c9:	c9                   	leave  
 9ca:	c3                   	ret    

000009cb <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 9cb:	55                   	push   %ebp
 9cc:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 9ce:	8b 45 08             	mov    0x8(%ebp),%eax
 9d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 9d7:	90                   	nop
}
 9d8:	5d                   	pop    %ebp
 9d9:	c3                   	ret    

000009da <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 9da:	55                   	push   %ebp
 9db:	89 e5                	mov    %esp,%ebp
 9dd:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 9e0:	90                   	nop
 9e1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 9e8:	00 
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
 9ec:	89 04 24             	mov    %eax,(%esp)
 9ef:	e8 0c ff ff ff       	call   900 <xchg>
 9f4:	85 c0                	test   %eax,%eax
 9f6:	75 e9                	jne    9e1 <pthread_mutex_lock+0x7>
  return;
 9f8:	90                   	nop
}
 9f9:	c9                   	leave  
 9fa:	c3                   	ret    

000009fb <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 9fb:	55                   	push   %ebp
 9fc:	89 e5                	mov    %esp,%ebp
 9fe:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 a01:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 a08:	00 
 a09:	8b 45 08             	mov    0x8(%ebp),%eax
 a0c:	89 04 24             	mov    %eax,(%esp)
 a0f:	e8 ec fe ff ff       	call   900 <xchg>
  return;
 a14:	90                   	nop
}
 a15:	c9                   	leave  
 a16:	c3                   	ret    

00000a17 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 a17:	55                   	push   %ebp
 a18:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 a1a:	8b 45 08             	mov    0x8(%ebp),%eax
 a1d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 a23:	8b 45 08             	mov    0x8(%ebp),%eax
 a26:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 a2d:	90                   	nop
}
 a2e:	5d                   	pop    %ebp
 a2f:	c3                   	ret    

00000a30 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	53                   	push   %ebx
 a34:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 a37:	8b 45 08             	mov    0x8(%ebp),%eax
 a3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
 a40:	89 04 24             	mov    %eax,(%esp)
 a43:	e8 b3 ff ff ff       	call   9fb <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 a48:	eb 09                	jmp    a53 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4d:	8b 40 04             	mov    0x4(%eax),%eax
 a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a56:	8b 40 04             	mov    0x4(%eax),%eax
 a59:	85 c0                	test   %eax,%eax
 a5b:	75 ed                	jne    a4a <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 a5d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 a64:	e8 b4 fd ff ff       	call   81d <malloc>
 a69:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a6c:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a72:	8b 58 04             	mov    0x4(%eax),%ebx
 a75:	e8 8e f9 ff ff       	call   408 <getpid>
 a7a:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 a7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a7f:	8b 40 04             	mov    0x4(%eax),%eax
 a82:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 a89:	8b 45 0c             	mov    0xc(%ebp),%eax
 a8c:	89 04 24             	mov    %eax,(%esp)
 a8f:	e8 46 ff ff ff       	call   9da <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 a94:	8b 45 0c             	mov    0xc(%ebp),%eax
 a97:	89 04 24             	mov    %eax,(%esp)
 a9a:	e8 5c ff ff ff       	call   9fb <pthread_mutex_unlock>
  threadSleep(mutex);
 a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
 aa2:	89 04 24             	mov    %eax,(%esp)
 aa5:	e8 96 f9 ff ff       	call   440 <threadSleep>
  pthread_mutex_lock(mutex);
 aaa:	8b 45 0c             	mov    0xc(%ebp),%eax
 aad:	89 04 24             	mov    %eax,(%esp)
 ab0:	e8 25 ff ff ff       	call   9da <pthread_mutex_lock>
  return;
 ab5:	90                   	nop
}
 ab6:	83 c4 24             	add    $0x24,%esp
 ab9:	5b                   	pop    %ebx
 aba:	5d                   	pop    %ebp
 abb:	c3                   	ret    

00000abc <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 abc:	55                   	push   %ebp
 abd:	89 e5                	mov    %esp,%ebp
 abf:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 ac2:	8b 45 08             	mov    0x8(%ebp),%eax
 ac5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 ac8:	eb 09                	jmp    ad3 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acd:	8b 40 04             	mov    0x4(%eax),%eax
 ad0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad6:	8b 00                	mov    (%eax),%eax
 ad8:	83 f8 ff             	cmp    $0xffffffff,%eax
 adb:	74 ed                	je     aca <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 add:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ae1:	74 33                	je     b16 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae6:	8b 00                	mov    (%eax),%eax
 ae8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 af1:	8b 45 08             	mov    0x8(%ebp),%eax
 af4:	8b 40 04             	mov    0x4(%eax),%eax
 af7:	8b 50 04             	mov    0x4(%eax),%edx
 afa:	8b 45 08             	mov    0x8(%ebp),%eax
 afd:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 b00:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b03:	89 04 24             	mov    %eax,(%esp)
 b06:	e8 d9 fb ff ff       	call   6e4 <free>
    threadWake(threadId);
 b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b0e:	89 04 24             	mov    %eax,(%esp)
 b11:	e8 32 f9 ff ff       	call   448 <threadWake>
  }
  return;
 b16:	90                   	nop
}
 b17:	c9                   	leave  
 b18:	c3                   	ret    

00000b19 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 b19:	55                   	push   %ebp
 b1a:	89 e5                	mov    %esp,%ebp
 b1c:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 b1f:	8b 45 08             	mov    0x8(%ebp),%eax
 b22:	8b 55 10             	mov    0x10(%ebp),%edx
 b25:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 b27:	8b 45 08             	mov    0x8(%ebp),%eax
 b2a:	83 c0 04             	add    $0x4,%eax
 b2d:	89 04 24             	mov    %eax,(%esp)
 b30:	e8 e2 fe ff ff       	call   a17 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 b35:	8b 45 08             	mov    0x8(%ebp),%eax
 b38:	83 c0 0c             	add    $0xc,%eax
 b3b:	89 04 24             	mov    %eax,(%esp)
 b3e:	e8 88 fe ff ff       	call   9cb <pthread_mutex_init>
  return;
 b43:	90                   	nop
}
 b44:	c9                   	leave  
 b45:	c3                   	ret    

00000b46 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 b46:	55                   	push   %ebp
 b47:	89 e5                	mov    %esp,%ebp
 b49:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 b4c:	8b 45 08             	mov    0x8(%ebp),%eax
 b4f:	8b 00                	mov    (%eax),%eax
 b51:	8d 50 ff             	lea    -0x1(%eax),%edx
 b54:	8b 45 08             	mov    0x8(%ebp),%eax
 b57:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 b59:	8b 45 08             	mov    0x8(%ebp),%eax
 b5c:	8b 00                	mov    (%eax),%eax
 b5e:	85 c0                	test   %eax,%eax
 b60:	79 18                	jns    b7a <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 b62:	8b 45 08             	mov    0x8(%ebp),%eax
 b65:	8d 50 0c             	lea    0xc(%eax),%edx
 b68:	8b 45 08             	mov    0x8(%ebp),%eax
 b6b:	83 c0 04             	add    $0x4,%eax
 b6e:	89 54 24 04          	mov    %edx,0x4(%esp)
 b72:	89 04 24             	mov    %eax,(%esp)
 b75:	e8 b6 fe ff ff       	call   a30 <pthread_cond_wait>
  }
  return;
 b7a:	90                   	nop
}
 b7b:	c9                   	leave  
 b7c:	c3                   	ret    

00000b7d <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 b7d:	55                   	push   %ebp
 b7e:	89 e5                	mov    %esp,%ebp
 b80:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 b83:	8b 45 08             	mov    0x8(%ebp),%eax
 b86:	8b 00                	mov    (%eax),%eax
 b88:	8d 50 01             	lea    0x1(%eax),%edx
 b8b:	8b 45 08             	mov    0x8(%ebp),%eax
 b8e:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 b90:	8b 45 08             	mov    0x8(%ebp),%eax
 b93:	83 c0 04             	add    $0x4,%eax
 b96:	89 04 24             	mov    %eax,(%esp)
 b99:	e8 1e ff ff ff       	call   abc <pthread_cond_signal>
  return;
 b9e:	90                   	nop
}
 b9f:	c9                   	leave  
 ba0:	c3                   	ret    
