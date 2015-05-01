
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	81 ec 30 02 00 00    	sub    $0x230,%esp
  int fd, i;
  char path[] = "stressfs0";
   c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
  13:	73 74 72 65 
  17:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
  1e:	73 73 66 73 
  22:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
  29:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	c7 44 24 04 38 0c 00 	movl   $0xc38,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 84 05 00 00       	call   5c4 <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  54:	89 04 24             	mov    %eax,(%esp)
  57:	e8 13 02 00 00       	call   26f <memset>

  for(i = 0; i < 4; i++)
  5c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  63:	00 00 00 00 
  67:	eb 13                	jmp    7c <main+0x7c>
    if(fork() > 0)
  69:	e8 a6 03 00 00       	call   414 <fork>
  6e:	85 c0                	test   %eax,%eax
  70:	7e 02                	jle    74 <main+0x74>
      break;
  72:	eb 12                	jmp    86 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  74:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
  7b:	01 
  7c:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
  83:	03 
  84:	7e e3                	jle    69 <main+0x69>
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  86:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  8d:	89 44 24 08          	mov    %eax,0x8(%esp)
  91:	c7 44 24 04 4b 0c 00 	movl   $0xc4b,0x4(%esp)
  98:	00 
  99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a0:	e8 1f 05 00 00       	call   5c4 <printf>

  path[8] += i;
  a5:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
  ac:	00 
  ad:	89 c2                	mov    %eax,%edx
  af:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  b6:	01 d0                	add    %edx,%eax
  b8:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  bf:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c6:	00 
  c7:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
  ce:	89 04 24             	mov    %eax,(%esp)
  d1:	e8 86 03 00 00       	call   45c <open>
  d6:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
  dd:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  e4:	00 00 00 00 
  e8:	eb 27                	jmp    111 <main+0x111>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  ea:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  f1:	00 
  f2:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  fa:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 101:	89 04 24             	mov    %eax,(%esp)
 104:	e8 33 03 00 00       	call   43c <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
 109:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 110:	01 
 111:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 118:	13 
 119:	7e cf                	jle    ea <main+0xea>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
 11b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 122:	89 04 24             	mov    %eax,(%esp)
 125:	e8 1a 03 00 00       	call   444 <close>

  printf(1, "read\n");
 12a:	c7 44 24 04 55 0c 00 	movl   $0xc55,0x4(%esp)
 131:	00 
 132:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 139:	e8 86 04 00 00       	call   5c4 <printf>

  fd = open(path, O_RDONLY);
 13e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 145:	00 
 146:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
 14d:	89 04 24             	mov    %eax,(%esp)
 150:	e8 07 03 00 00       	call   45c <open>
 155:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
 15c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
 163:	00 00 00 00 
 167:	eb 27                	jmp    190 <main+0x190>
    read(fd, data, sizeof(data));
 169:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 170:	00 
 171:	8d 44 24 1e          	lea    0x1e(%esp),%eax
 175:	89 44 24 04          	mov    %eax,0x4(%esp)
 179:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 180:	89 04 24             	mov    %eax,(%esp)
 183:	e8 ac 02 00 00       	call   434 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 188:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 18f:	01 
 190:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 197:	13 
 198:	7e cf                	jle    169 <main+0x169>
    read(fd, data, sizeof(data));
  close(fd);
 19a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 1a1:	89 04 24             	mov    %eax,(%esp)
 1a4:	e8 9b 02 00 00       	call   444 <close>

  wait();
 1a9:	e8 76 02 00 00       	call   424 <wait>
  
  exit();
 1ae:	e8 69 02 00 00       	call   41c <exit>
 1b3:	90                   	nop

000001b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bc:	8b 55 10             	mov    0x10(%ebp),%edx
 1bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c2:	89 cb                	mov    %ecx,%ebx
 1c4:	89 df                	mov    %ebx,%edi
 1c6:	89 d1                	mov    %edx,%ecx
 1c8:	fc                   	cld    
 1c9:	f3 aa                	rep stos %al,%es:(%edi)
 1cb:	89 ca                	mov    %ecx,%edx
 1cd:	89 fb                	mov    %edi,%ebx
 1cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d5:	5b                   	pop    %ebx
 1d6:	5f                   	pop    %edi
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    

000001d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
 1dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e5:	90                   	nop
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	8d 50 01             	lea    0x1(%eax),%edx
 1ec:	89 55 08             	mov    %edx,0x8(%ebp)
 1ef:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f2:	8d 4a 01             	lea    0x1(%edx),%ecx
 1f5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1f8:	0f b6 12             	movzbl (%edx),%edx
 1fb:	88 10                	mov    %dl,(%eax)
 1fd:	0f b6 00             	movzbl (%eax),%eax
 200:	84 c0                	test   %al,%al
 202:	75 e2                	jne    1e6 <strcpy+0xd>
    ;
  return os;
 204:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 207:	c9                   	leave  
 208:	c3                   	ret    

00000209 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 209:	55                   	push   %ebp
 20a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 20c:	eb 08                	jmp    216 <strcmp+0xd>
    p++, q++;
 20e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 212:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	0f b6 00             	movzbl (%eax),%eax
 21c:	84 c0                	test   %al,%al
 21e:	74 10                	je     230 <strcmp+0x27>
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	0f b6 10             	movzbl (%eax),%edx
 226:	8b 45 0c             	mov    0xc(%ebp),%eax
 229:	0f b6 00             	movzbl (%eax),%eax
 22c:	38 c2                	cmp    %al,%dl
 22e:	74 de                	je     20e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	0f b6 00             	movzbl (%eax),%eax
 236:	0f b6 d0             	movzbl %al,%edx
 239:	8b 45 0c             	mov    0xc(%ebp),%eax
 23c:	0f b6 00             	movzbl (%eax),%eax
 23f:	0f b6 c0             	movzbl %al,%eax
 242:	29 c2                	sub    %eax,%edx
 244:	89 d0                	mov    %edx,%eax
}
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    

00000248 <strlen>:

uint
strlen(char *s)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 24e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 255:	eb 04                	jmp    25b <strlen+0x13>
 257:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 25b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	01 d0                	add    %edx,%eax
 263:	0f b6 00             	movzbl (%eax),%eax
 266:	84 c0                	test   %al,%al
 268:	75 ed                	jne    257 <strlen+0xf>
    ;
  return n;
 26a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26d:	c9                   	leave  
 26e:	c3                   	ret    

0000026f <memset>:

void*
memset(void *dst, int c, uint n)
{
 26f:	55                   	push   %ebp
 270:	89 e5                	mov    %esp,%ebp
 272:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 275:	8b 45 10             	mov    0x10(%ebp),%eax
 278:	89 44 24 08          	mov    %eax,0x8(%esp)
 27c:	8b 45 0c             	mov    0xc(%ebp),%eax
 27f:	89 44 24 04          	mov    %eax,0x4(%esp)
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	89 04 24             	mov    %eax,(%esp)
 289:	e8 26 ff ff ff       	call   1b4 <stosb>
  return dst;
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 291:	c9                   	leave  
 292:	c3                   	ret    

00000293 <strchr>:

char*
strchr(const char *s, char c)
{
 293:	55                   	push   %ebp
 294:	89 e5                	mov    %esp,%ebp
 296:	83 ec 04             	sub    $0x4,%esp
 299:	8b 45 0c             	mov    0xc(%ebp),%eax
 29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 29f:	eb 14                	jmp    2b5 <strchr+0x22>
    if(*s == c)
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	0f b6 00             	movzbl (%eax),%eax
 2a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2aa:	75 05                	jne    2b1 <strchr+0x1e>
      return (char*)s;
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	eb 13                	jmp    2c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	84 c0                	test   %al,%al
 2bd:	75 e2                	jne    2a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d3:	eb 4c                	jmp    321 <gets+0x5b>
    cc = read(0, &c, 1);
 2d5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2dc:	00 
 2dd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2eb:	e8 44 01 00 00       	call   434 <read>
 2f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2f7:	7f 02                	jg     2fb <gets+0x35>
      break;
 2f9:	eb 31                	jmp    32c <gets+0x66>
    buf[i++] = c;
 2fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2fe:	8d 50 01             	lea    0x1(%eax),%edx
 301:	89 55 f4             	mov    %edx,-0xc(%ebp)
 304:	89 c2                	mov    %eax,%edx
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	01 c2                	add    %eax,%edx
 30b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 311:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 315:	3c 0a                	cmp    $0xa,%al
 317:	74 13                	je     32c <gets+0x66>
 319:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31d:	3c 0d                	cmp    $0xd,%al
 31f:	74 0b                	je     32c <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 321:	8b 45 f4             	mov    -0xc(%ebp),%eax
 324:	83 c0 01             	add    $0x1,%eax
 327:	3b 45 0c             	cmp    0xc(%ebp),%eax
 32a:	7c a9                	jl     2d5 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 32f:	8b 45 08             	mov    0x8(%ebp),%eax
 332:	01 d0                	add    %edx,%eax
 334:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 337:	8b 45 08             	mov    0x8(%ebp),%eax
}
 33a:	c9                   	leave  
 33b:	c3                   	ret    

0000033c <stat>:

int
stat(char *n, struct stat *st)
{
 33c:	55                   	push   %ebp
 33d:	89 e5                	mov    %esp,%ebp
 33f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 342:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 349:	00 
 34a:	8b 45 08             	mov    0x8(%ebp),%eax
 34d:	89 04 24             	mov    %eax,(%esp)
 350:	e8 07 01 00 00       	call   45c <open>
 355:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 358:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 35c:	79 07                	jns    365 <stat+0x29>
    return -1;
 35e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 363:	eb 23                	jmp    388 <stat+0x4c>
  r = fstat(fd, st);
 365:	8b 45 0c             	mov    0xc(%ebp),%eax
 368:	89 44 24 04          	mov    %eax,0x4(%esp)
 36c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36f:	89 04 24             	mov    %eax,(%esp)
 372:	e8 fd 00 00 00       	call   474 <fstat>
 377:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 37a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 37d:	89 04 24             	mov    %eax,(%esp)
 380:	e8 bf 00 00 00       	call   444 <close>
  return r;
 385:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 388:	c9                   	leave  
 389:	c3                   	ret    

0000038a <atoi>:

int
atoi(const char *s)
{
 38a:	55                   	push   %ebp
 38b:	89 e5                	mov    %esp,%ebp
 38d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 390:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 397:	eb 25                	jmp    3be <atoi+0x34>
    n = n*10 + *s++ - '0';
 399:	8b 55 fc             	mov    -0x4(%ebp),%edx
 39c:	89 d0                	mov    %edx,%eax
 39e:	c1 e0 02             	shl    $0x2,%eax
 3a1:	01 d0                	add    %edx,%eax
 3a3:	01 c0                	add    %eax,%eax
 3a5:	89 c1                	mov    %eax,%ecx
 3a7:	8b 45 08             	mov    0x8(%ebp),%eax
 3aa:	8d 50 01             	lea    0x1(%eax),%edx
 3ad:	89 55 08             	mov    %edx,0x8(%ebp)
 3b0:	0f b6 00             	movzbl (%eax),%eax
 3b3:	0f be c0             	movsbl %al,%eax
 3b6:	01 c8                	add    %ecx,%eax
 3b8:	83 e8 30             	sub    $0x30,%eax
 3bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3be:	8b 45 08             	mov    0x8(%ebp),%eax
 3c1:	0f b6 00             	movzbl (%eax),%eax
 3c4:	3c 2f                	cmp    $0x2f,%al
 3c6:	7e 0a                	jle    3d2 <atoi+0x48>
 3c8:	8b 45 08             	mov    0x8(%ebp),%eax
 3cb:	0f b6 00             	movzbl (%eax),%eax
 3ce:	3c 39                	cmp    $0x39,%al
 3d0:	7e c7                	jle    399 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d5:	c9                   	leave  
 3d6:	c3                   	ret    

000003d7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d7:	55                   	push   %ebp
 3d8:	89 e5                	mov    %esp,%ebp
 3da:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e9:	eb 17                	jmp    402 <memmove+0x2b>
    *dst++ = *src++;
 3eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ee:	8d 50 01             	lea    0x1(%eax),%edx
 3f1:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3f4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3f7:	8d 4a 01             	lea    0x1(%edx),%ecx
 3fa:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3fd:	0f b6 12             	movzbl (%edx),%edx
 400:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 402:	8b 45 10             	mov    0x10(%ebp),%eax
 405:	8d 50 ff             	lea    -0x1(%eax),%edx
 408:	89 55 10             	mov    %edx,0x10(%ebp)
 40b:	85 c0                	test   %eax,%eax
 40d:	7f dc                	jg     3eb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 40f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 412:	c9                   	leave  
 413:	c3                   	ret    

00000414 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 414:	b8 01 00 00 00       	mov    $0x1,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <exit>:
SYSCALL(exit)
 41c:	b8 02 00 00 00       	mov    $0x2,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <wait>:
SYSCALL(wait)
 424:	b8 03 00 00 00       	mov    $0x3,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <pipe>:
SYSCALL(pipe)
 42c:	b8 04 00 00 00       	mov    $0x4,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <read>:
SYSCALL(read)
 434:	b8 05 00 00 00       	mov    $0x5,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <write>:
SYSCALL(write)
 43c:	b8 10 00 00 00       	mov    $0x10,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <close>:
SYSCALL(close)
 444:	b8 15 00 00 00       	mov    $0x15,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <kill>:
SYSCALL(kill)
 44c:	b8 06 00 00 00       	mov    $0x6,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <exec>:
SYSCALL(exec)
 454:	b8 07 00 00 00       	mov    $0x7,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <open>:
SYSCALL(open)
 45c:	b8 0f 00 00 00       	mov    $0xf,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <mknod>:
SYSCALL(mknod)
 464:	b8 11 00 00 00       	mov    $0x11,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <unlink>:
SYSCALL(unlink)
 46c:	b8 12 00 00 00       	mov    $0x12,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <fstat>:
SYSCALL(fstat)
 474:	b8 08 00 00 00       	mov    $0x8,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <link>:
SYSCALL(link)
 47c:	b8 13 00 00 00       	mov    $0x13,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <mkdir>:
SYSCALL(mkdir)
 484:	b8 14 00 00 00       	mov    $0x14,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <chdir>:
SYSCALL(chdir)
 48c:	b8 09 00 00 00       	mov    $0x9,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <dup>:
SYSCALL(dup)
 494:	b8 0a 00 00 00       	mov    $0xa,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <getpid>:
SYSCALL(getpid)
 49c:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <sbrk>:
SYSCALL(sbrk)
 4a4:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <sleep>:
SYSCALL(sleep)
 4ac:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <uptime>:
SYSCALL(uptime)
 4b4:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <date>:
SYSCALL(date)
 4bc:	b8 16 00 00 00       	mov    $0x16,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <clone>:
SYSCALL(clone)
 4c4:	b8 17 00 00 00       	mov    $0x17,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <join>:
SYSCALL(join)
 4cc:	b8 18 00 00 00       	mov    $0x18,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <threadSleep>:
SYSCALL(threadSleep)
 4d4:	b8 19 00 00 00       	mov    $0x19,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <threadWake>:
SYSCALL(threadWake)
 4dc:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	83 ec 18             	sub    $0x18,%esp
 4ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ed:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f7:	00 
 4f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ff:	8b 45 08             	mov    0x8(%ebp),%eax
 502:	89 04 24             	mov    %eax,(%esp)
 505:	e8 32 ff ff ff       	call   43c <write>
}
 50a:	c9                   	leave  
 50b:	c3                   	ret    

0000050c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50c:	55                   	push   %ebp
 50d:	89 e5                	mov    %esp,%ebp
 50f:	56                   	push   %esi
 510:	53                   	push   %ebx
 511:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 514:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 51b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 51f:	74 17                	je     538 <printint+0x2c>
 521:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 525:	79 11                	jns    538 <printint+0x2c>
    neg = 1;
 527:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 52e:	8b 45 0c             	mov    0xc(%ebp),%eax
 531:	f7 d8                	neg    %eax
 533:	89 45 ec             	mov    %eax,-0x14(%ebp)
 536:	eb 06                	jmp    53e <printint+0x32>
  } else {
    x = xx;
 538:	8b 45 0c             	mov    0xc(%ebp),%eax
 53b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 53e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 545:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 548:	8d 41 01             	lea    0x1(%ecx),%eax
 54b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 54e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 551:	8b 45 ec             	mov    -0x14(%ebp),%eax
 554:	ba 00 00 00 00       	mov    $0x0,%edx
 559:	f7 f3                	div    %ebx
 55b:	89 d0                	mov    %edx,%eax
 55d:	0f b6 80 58 10 00 00 	movzbl 0x1058(%eax),%eax
 564:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 568:	8b 75 10             	mov    0x10(%ebp),%esi
 56b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 56e:	ba 00 00 00 00       	mov    $0x0,%edx
 573:	f7 f6                	div    %esi
 575:	89 45 ec             	mov    %eax,-0x14(%ebp)
 578:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 57c:	75 c7                	jne    545 <printint+0x39>
  if(neg)
 57e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 582:	74 10                	je     594 <printint+0x88>
    buf[i++] = '-';
 584:	8b 45 f4             	mov    -0xc(%ebp),%eax
 587:	8d 50 01             	lea    0x1(%eax),%edx
 58a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 58d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 592:	eb 1f                	jmp    5b3 <printint+0xa7>
 594:	eb 1d                	jmp    5b3 <printint+0xa7>
    putc(fd, buf[i]);
 596:	8d 55 dc             	lea    -0x24(%ebp),%edx
 599:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59c:	01 d0                	add    %edx,%eax
 59e:	0f b6 00             	movzbl (%eax),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
 5ab:	89 04 24             	mov    %eax,(%esp)
 5ae:	e8 31 ff ff ff       	call   4e4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5b3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5bb:	79 d9                	jns    596 <printint+0x8a>
    putc(fd, buf[i]);
}
 5bd:	83 c4 30             	add    $0x30,%esp
 5c0:	5b                   	pop    %ebx
 5c1:	5e                   	pop    %esi
 5c2:	5d                   	pop    %ebp
 5c3:	c3                   	ret    

000005c4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c4:	55                   	push   %ebp
 5c5:	89 e5                	mov    %esp,%ebp
 5c7:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5d1:	8d 45 0c             	lea    0xc(%ebp),%eax
 5d4:	83 c0 04             	add    $0x4,%eax
 5d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5e1:	e9 7c 01 00 00       	jmp    762 <printf+0x19e>
    c = fmt[i] & 0xff;
 5e6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ec:	01 d0                	add    %edx,%eax
 5ee:	0f b6 00             	movzbl (%eax),%eax
 5f1:	0f be c0             	movsbl %al,%eax
 5f4:	25 ff 00 00 00       	and    $0xff,%eax
 5f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 600:	75 2c                	jne    62e <printf+0x6a>
      if(c == '%'){
 602:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 606:	75 0c                	jne    614 <printf+0x50>
        state = '%';
 608:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 60f:	e9 4a 01 00 00       	jmp    75e <printf+0x19a>
      } else {
        putc(fd, c);
 614:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 617:	0f be c0             	movsbl %al,%eax
 61a:	89 44 24 04          	mov    %eax,0x4(%esp)
 61e:	8b 45 08             	mov    0x8(%ebp),%eax
 621:	89 04 24             	mov    %eax,(%esp)
 624:	e8 bb fe ff ff       	call   4e4 <putc>
 629:	e9 30 01 00 00       	jmp    75e <printf+0x19a>
      }
    } else if(state == '%'){
 62e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 632:	0f 85 26 01 00 00    	jne    75e <printf+0x19a>
      if(c == 'd'){
 638:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 63c:	75 2d                	jne    66b <printf+0xa7>
        printint(fd, *ap, 10, 1);
 63e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 641:	8b 00                	mov    (%eax),%eax
 643:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 64a:	00 
 64b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 652:	00 
 653:	89 44 24 04          	mov    %eax,0x4(%esp)
 657:	8b 45 08             	mov    0x8(%ebp),%eax
 65a:	89 04 24             	mov    %eax,(%esp)
 65d:	e8 aa fe ff ff       	call   50c <printint>
        ap++;
 662:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 666:	e9 ec 00 00 00       	jmp    757 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 66b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 66f:	74 06                	je     677 <printf+0xb3>
 671:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 675:	75 2d                	jne    6a4 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 677:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 683:	00 
 684:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 68b:	00 
 68c:	89 44 24 04          	mov    %eax,0x4(%esp)
 690:	8b 45 08             	mov    0x8(%ebp),%eax
 693:	89 04 24             	mov    %eax,(%esp)
 696:	e8 71 fe ff ff       	call   50c <printint>
        ap++;
 69b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69f:	e9 b3 00 00 00       	jmp    757 <printf+0x193>
      } else if(c == 's'){
 6a4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6a8:	75 45                	jne    6ef <printf+0x12b>
        s = (char*)*ap;
 6aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ad:	8b 00                	mov    (%eax),%eax
 6af:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6ba:	75 09                	jne    6c5 <printf+0x101>
          s = "(null)";
 6bc:	c7 45 f4 5b 0c 00 00 	movl   $0xc5b,-0xc(%ebp)
        while(*s != 0){
 6c3:	eb 1e                	jmp    6e3 <printf+0x11f>
 6c5:	eb 1c                	jmp    6e3 <printf+0x11f>
          putc(fd, *s);
 6c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ca:	0f b6 00             	movzbl (%eax),%eax
 6cd:	0f be c0             	movsbl %al,%eax
 6d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d4:	8b 45 08             	mov    0x8(%ebp),%eax
 6d7:	89 04 24             	mov    %eax,(%esp)
 6da:	e8 05 fe ff ff       	call   4e4 <putc>
          s++;
 6df:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e6:	0f b6 00             	movzbl (%eax),%eax
 6e9:	84 c0                	test   %al,%al
 6eb:	75 da                	jne    6c7 <printf+0x103>
 6ed:	eb 68                	jmp    757 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ef:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6f3:	75 1d                	jne    712 <printf+0x14e>
        putc(fd, *ap);
 6f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6f8:	8b 00                	mov    (%eax),%eax
 6fa:	0f be c0             	movsbl %al,%eax
 6fd:	89 44 24 04          	mov    %eax,0x4(%esp)
 701:	8b 45 08             	mov    0x8(%ebp),%eax
 704:	89 04 24             	mov    %eax,(%esp)
 707:	e8 d8 fd ff ff       	call   4e4 <putc>
        ap++;
 70c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 710:	eb 45                	jmp    757 <printf+0x193>
      } else if(c == '%'){
 712:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 716:	75 17                	jne    72f <printf+0x16b>
        putc(fd, c);
 718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71b:	0f be c0             	movsbl %al,%eax
 71e:	89 44 24 04          	mov    %eax,0x4(%esp)
 722:	8b 45 08             	mov    0x8(%ebp),%eax
 725:	89 04 24             	mov    %eax,(%esp)
 728:	e8 b7 fd ff ff       	call   4e4 <putc>
 72d:	eb 28                	jmp    757 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 72f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 736:	00 
 737:	8b 45 08             	mov    0x8(%ebp),%eax
 73a:	89 04 24             	mov    %eax,(%esp)
 73d:	e8 a2 fd ff ff       	call   4e4 <putc>
        putc(fd, c);
 742:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 745:	0f be c0             	movsbl %al,%eax
 748:	89 44 24 04          	mov    %eax,0x4(%esp)
 74c:	8b 45 08             	mov    0x8(%ebp),%eax
 74f:	89 04 24             	mov    %eax,(%esp)
 752:	e8 8d fd ff ff       	call   4e4 <putc>
      }
      state = 0;
 757:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 75e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 762:	8b 55 0c             	mov    0xc(%ebp),%edx
 765:	8b 45 f0             	mov    -0x10(%ebp),%eax
 768:	01 d0                	add    %edx,%eax
 76a:	0f b6 00             	movzbl (%eax),%eax
 76d:	84 c0                	test   %al,%al
 76f:	0f 85 71 fe ff ff    	jne    5e6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 775:	c9                   	leave  
 776:	c3                   	ret    
 777:	90                   	nop

00000778 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 778:	55                   	push   %ebp
 779:	89 e5                	mov    %esp,%ebp
 77b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 77e:	8b 45 08             	mov    0x8(%ebp),%eax
 781:	83 e8 08             	sub    $0x8,%eax
 784:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 787:	a1 74 10 00 00       	mov    0x1074,%eax
 78c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 78f:	eb 24                	jmp    7b5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 791:	8b 45 fc             	mov    -0x4(%ebp),%eax
 794:	8b 00                	mov    (%eax),%eax
 796:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 799:	77 12                	ja     7ad <free+0x35>
 79b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a1:	77 24                	ja     7c7 <free+0x4f>
 7a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a6:	8b 00                	mov    (%eax),%eax
 7a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ab:	77 1a                	ja     7c7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b0:	8b 00                	mov    (%eax),%eax
 7b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7bb:	76 d4                	jbe    791 <free+0x19>
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 00                	mov    (%eax),%eax
 7c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7c5:	76 ca                	jbe    791 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ca:	8b 40 04             	mov    0x4(%eax),%eax
 7cd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d7:	01 c2                	add    %eax,%edx
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	39 c2                	cmp    %eax,%edx
 7e0:	75 24                	jne    806 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e5:	8b 50 04             	mov    0x4(%eax),%edx
 7e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7eb:	8b 00                	mov    (%eax),%eax
 7ed:	8b 40 04             	mov    0x4(%eax),%eax
 7f0:	01 c2                	add    %eax,%edx
 7f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fb:	8b 00                	mov    (%eax),%eax
 7fd:	8b 10                	mov    (%eax),%edx
 7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 802:	89 10                	mov    %edx,(%eax)
 804:	eb 0a                	jmp    810 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 806:	8b 45 fc             	mov    -0x4(%ebp),%eax
 809:	8b 10                	mov    (%eax),%edx
 80b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 810:	8b 45 fc             	mov    -0x4(%ebp),%eax
 813:	8b 40 04             	mov    0x4(%eax),%eax
 816:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 81d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 820:	01 d0                	add    %edx,%eax
 822:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 825:	75 20                	jne    847 <free+0xcf>
    p->s.size += bp->s.size;
 827:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82a:	8b 50 04             	mov    0x4(%eax),%edx
 82d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 830:	8b 40 04             	mov    0x4(%eax),%eax
 833:	01 c2                	add    %eax,%edx
 835:	8b 45 fc             	mov    -0x4(%ebp),%eax
 838:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 83b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83e:	8b 10                	mov    (%eax),%edx
 840:	8b 45 fc             	mov    -0x4(%ebp),%eax
 843:	89 10                	mov    %edx,(%eax)
 845:	eb 08                	jmp    84f <free+0xd7>
  } else
    p->s.ptr = bp;
 847:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 84d:	89 10                	mov    %edx,(%eax)
  freep = p;
 84f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 852:	a3 74 10 00 00       	mov    %eax,0x1074
}
 857:	c9                   	leave  
 858:	c3                   	ret    

00000859 <morecore>:

static Header*
morecore(uint nu)
{
 859:	55                   	push   %ebp
 85a:	89 e5                	mov    %esp,%ebp
 85c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 85f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 866:	77 07                	ja     86f <morecore+0x16>
    nu = 4096;
 868:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 86f:	8b 45 08             	mov    0x8(%ebp),%eax
 872:	c1 e0 03             	shl    $0x3,%eax
 875:	89 04 24             	mov    %eax,(%esp)
 878:	e8 27 fc ff ff       	call   4a4 <sbrk>
 87d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 880:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 884:	75 07                	jne    88d <morecore+0x34>
    return 0;
 886:	b8 00 00 00 00       	mov    $0x0,%eax
 88b:	eb 22                	jmp    8af <morecore+0x56>
  hp = (Header*)p;
 88d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 890:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 893:	8b 45 f0             	mov    -0x10(%ebp),%eax
 896:	8b 55 08             	mov    0x8(%ebp),%edx
 899:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 89c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89f:	83 c0 08             	add    $0x8,%eax
 8a2:	89 04 24             	mov    %eax,(%esp)
 8a5:	e8 ce fe ff ff       	call   778 <free>
  return freep;
 8aa:	a1 74 10 00 00       	mov    0x1074,%eax
}
 8af:	c9                   	leave  
 8b0:	c3                   	ret    

000008b1 <malloc>:

void*
malloc(uint nbytes)
{
 8b1:	55                   	push   %ebp
 8b2:	89 e5                	mov    %esp,%ebp
 8b4:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b7:	8b 45 08             	mov    0x8(%ebp),%eax
 8ba:	83 c0 07             	add    $0x7,%eax
 8bd:	c1 e8 03             	shr    $0x3,%eax
 8c0:	83 c0 01             	add    $0x1,%eax
 8c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8c6:	a1 74 10 00 00       	mov    0x1074,%eax
 8cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8d2:	75 23                	jne    8f7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8d4:	c7 45 f0 6c 10 00 00 	movl   $0x106c,-0x10(%ebp)
 8db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8de:	a3 74 10 00 00       	mov    %eax,0x1074
 8e3:	a1 74 10 00 00       	mov    0x1074,%eax
 8e8:	a3 6c 10 00 00       	mov    %eax,0x106c
    base.s.size = 0;
 8ed:	c7 05 70 10 00 00 00 	movl   $0x0,0x1070
 8f4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fa:	8b 00                	mov    (%eax),%eax
 8fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 902:	8b 40 04             	mov    0x4(%eax),%eax
 905:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 908:	72 4d                	jb     957 <malloc+0xa6>
      if(p->s.size == nunits)
 90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90d:	8b 40 04             	mov    0x4(%eax),%eax
 910:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 913:	75 0c                	jne    921 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 915:	8b 45 f4             	mov    -0xc(%ebp),%eax
 918:	8b 10                	mov    (%eax),%edx
 91a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91d:	89 10                	mov    %edx,(%eax)
 91f:	eb 26                	jmp    947 <malloc+0x96>
      else {
        p->s.size -= nunits;
 921:	8b 45 f4             	mov    -0xc(%ebp),%eax
 924:	8b 40 04             	mov    0x4(%eax),%eax
 927:	2b 45 ec             	sub    -0x14(%ebp),%eax
 92a:	89 c2                	mov    %eax,%edx
 92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 932:	8b 45 f4             	mov    -0xc(%ebp),%eax
 935:	8b 40 04             	mov    0x4(%eax),%eax
 938:	c1 e0 03             	shl    $0x3,%eax
 93b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	8b 55 ec             	mov    -0x14(%ebp),%edx
 944:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 947:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94a:	a3 74 10 00 00       	mov    %eax,0x1074
      return (void*)(p + 1);
 94f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 952:	83 c0 08             	add    $0x8,%eax
 955:	eb 38                	jmp    98f <malloc+0xde>
    }
    if(p == freep)
 957:	a1 74 10 00 00       	mov    0x1074,%eax
 95c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 95f:	75 1b                	jne    97c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 961:	8b 45 ec             	mov    -0x14(%ebp),%eax
 964:	89 04 24             	mov    %eax,(%esp)
 967:	e8 ed fe ff ff       	call   859 <morecore>
 96c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 973:	75 07                	jne    97c <malloc+0xcb>
        return 0;
 975:	b8 00 00 00 00       	mov    $0x0,%eax
 97a:	eb 13                	jmp    98f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 982:	8b 45 f4             	mov    -0xc(%ebp),%eax
 985:	8b 00                	mov    (%eax),%eax
 987:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 98a:	e9 70 ff ff ff       	jmp    8ff <malloc+0x4e>
}
 98f:	c9                   	leave  
 990:	c3                   	ret    
 991:	66 90                	xchg   %ax,%ax
 993:	90                   	nop

00000994 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 994:	55                   	push   %ebp
 995:	89 e5                	mov    %esp,%ebp
 997:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 99a:	8b 55 08             	mov    0x8(%ebp),%edx
 99d:	8b 45 0c             	mov    0xc(%ebp),%eax
 9a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
 9a3:	f0 87 02             	lock xchg %eax,(%edx)
 9a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 9a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 9ac:	c9                   	leave  
 9ad:	c3                   	ret    

000009ae <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 9ae:	55                   	push   %ebp
 9af:	89 e5                	mov    %esp,%ebp
 9b1:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 9b4:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 9bb:	e8 f1 fe ff ff       	call   8b1 <malloc>
 9c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 9c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c6:	85 c0                	test   %eax,%eax
 9c8:	75 1b                	jne    9e5 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 9ca:	c7 44 24 04 64 0c 00 	movl   $0xc64,0x4(%esp)
 9d1:	00 
 9d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9d9:	e8 e6 fb ff ff       	call   5c4 <printf>
    return -1;
 9de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9e3:	eb 43                	jmp    a28 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 9e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e8:	25 ff 0f 00 00       	and    $0xfff,%eax
 9ed:	85 c0                	test   %eax,%eax
 9ef:	74 14                	je     a05 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 9f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f4:	25 ff 0f 00 00       	and    $0xfff,%eax
 9f9:	89 c2                	mov    %eax,%edx
 9fb:	b8 00 10 00 00       	mov    $0x1000,%eax
 a00:	29 d0                	sub    %edx,%eax
 a02:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a08:	89 44 24 08          	mov    %eax,0x8(%esp)
 a0c:	8b 45 14             	mov    0x14(%ebp),%eax
 a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
 a13:	8b 45 10             	mov    0x10(%ebp),%eax
 a16:	89 04 24             	mov    %eax,(%esp)
 a19:	e8 a6 fa ff ff       	call   4c4 <clone>
 a1e:	8b 55 08             	mov    0x8(%ebp),%edx
 a21:	89 02                	mov    %eax,(%edx)
  return *thread;
 a23:	8b 45 08             	mov    0x8(%ebp),%eax
 a26:	8b 00                	mov    (%eax),%eax
}
 a28:	c9                   	leave  
 a29:	c3                   	ret    

00000a2a <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 a2a:	55                   	push   %ebp
 a2b:	89 e5                	mov    %esp,%ebp
 a2d:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 a30:	8d 45 f4             	lea    -0xc(%ebp),%eax
 a33:	89 44 24 04          	mov    %eax,0x4(%esp)
 a37:	8b 45 08             	mov    0x8(%ebp),%eax
 a3a:	89 04 24             	mov    %eax,(%esp)
 a3d:	e8 8a fa ff ff       	call   4cc <join>
 a42:	85 c0                	test   %eax,%eax
 a44:	79 07                	jns    a4d <pthread_join+0x23>
    return -1;
 a46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a4b:	eb 10                	jmp    a5d <pthread_join+0x33>
  }
  free(stack);
 a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a50:	89 04 24             	mov    %eax,(%esp)
 a53:	e8 20 fd ff ff       	call   778 <free>
  return 0;
 a58:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a5d:	c9                   	leave  
 a5e:	c3                   	ret    

00000a5f <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 a5f:	55                   	push   %ebp
 a60:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 a62:	8b 45 08             	mov    0x8(%ebp),%eax
 a65:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 a6b:	90                   	nop
}
 a6c:	5d                   	pop    %ebp
 a6d:	c3                   	ret    

00000a6e <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 a6e:	55                   	push   %ebp
 a6f:	89 e5                	mov    %esp,%ebp
 a71:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 a74:	90                   	nop
 a75:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 a7c:	00 
 a7d:	8b 45 08             	mov    0x8(%ebp),%eax
 a80:	89 04 24             	mov    %eax,(%esp)
 a83:	e8 0c ff ff ff       	call   994 <xchg>
 a88:	85 c0                	test   %eax,%eax
 a8a:	75 e9                	jne    a75 <pthread_mutex_lock+0x7>
  return;
 a8c:	90                   	nop
}
 a8d:	c9                   	leave  
 a8e:	c3                   	ret    

00000a8f <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 a8f:	55                   	push   %ebp
 a90:	89 e5                	mov    %esp,%ebp
 a92:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 a95:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 a9c:	00 
 a9d:	8b 45 08             	mov    0x8(%ebp),%eax
 aa0:	89 04 24             	mov    %eax,(%esp)
 aa3:	e8 ec fe ff ff       	call   994 <xchg>
  return;
 aa8:	90                   	nop
}
 aa9:	c9                   	leave  
 aaa:	c3                   	ret    

00000aab <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 aab:	55                   	push   %ebp
 aac:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 aae:	8b 45 08             	mov    0x8(%ebp),%eax
 ab1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 ab7:	8b 45 08             	mov    0x8(%ebp),%eax
 aba:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 ac1:	90                   	nop
}
 ac2:	5d                   	pop    %ebp
 ac3:	c3                   	ret    

00000ac4 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 ac4:	55                   	push   %ebp
 ac5:	89 e5                	mov    %esp,%ebp
 ac7:	53                   	push   %ebx
 ac8:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 acb:	8b 45 08             	mov    0x8(%ebp),%eax
 ace:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 ad1:	8b 45 0c             	mov    0xc(%ebp),%eax
 ad4:	89 04 24             	mov    %eax,(%esp)
 ad7:	e8 b3 ff ff ff       	call   a8f <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 adc:	eb 09                	jmp    ae7 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae1:	8b 40 04             	mov    0x4(%eax),%eax
 ae4:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aea:	8b 40 04             	mov    0x4(%eax),%eax
 aed:	85 c0                	test   %eax,%eax
 aef:	75 ed                	jne    ade <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 af1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 af8:	e8 b4 fd ff ff       	call   8b1 <malloc>
 afd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b00:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b06:	8b 58 04             	mov    0x4(%eax),%ebx
 b09:	e8 8e f9 ff ff       	call   49c <getpid>
 b0e:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b13:	8b 40 04             	mov    0x4(%eax),%eax
 b16:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 b1d:	8b 45 0c             	mov    0xc(%ebp),%eax
 b20:	89 04 24             	mov    %eax,(%esp)
 b23:	e8 46 ff ff ff       	call   a6e <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 b28:	8b 45 0c             	mov    0xc(%ebp),%eax
 b2b:	89 04 24             	mov    %eax,(%esp)
 b2e:	e8 5c ff ff ff       	call   a8f <pthread_mutex_unlock>
  threadSleep(mutex);
 b33:	8b 45 0c             	mov    0xc(%ebp),%eax
 b36:	89 04 24             	mov    %eax,(%esp)
 b39:	e8 96 f9 ff ff       	call   4d4 <threadSleep>
  pthread_mutex_lock(mutex);
 b3e:	8b 45 0c             	mov    0xc(%ebp),%eax
 b41:	89 04 24             	mov    %eax,(%esp)
 b44:	e8 25 ff ff ff       	call   a6e <pthread_mutex_lock>
  return;
 b49:	90                   	nop
}
 b4a:	83 c4 24             	add    $0x24,%esp
 b4d:	5b                   	pop    %ebx
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret    

00000b50 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 b56:	8b 45 08             	mov    0x8(%ebp),%eax
 b59:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 b5c:	eb 09                	jmp    b67 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b61:	8b 40 04             	mov    0x4(%eax),%eax
 b64:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6a:	8b 00                	mov    (%eax),%eax
 b6c:	83 f8 ff             	cmp    $0xffffffff,%eax
 b6f:	74 ed                	je     b5e <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 b71:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b75:	74 33                	je     baa <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b7a:	8b 00                	mov    (%eax),%eax
 b7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b82:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 b85:	8b 45 08             	mov    0x8(%ebp),%eax
 b88:	8b 40 04             	mov    0x4(%eax),%eax
 b8b:	8b 50 04             	mov    0x4(%eax),%edx
 b8e:	8b 45 08             	mov    0x8(%ebp),%eax
 b91:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 b94:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b97:	89 04 24             	mov    %eax,(%esp)
 b9a:	e8 d9 fb ff ff       	call   778 <free>
    threadWake(threadId);
 b9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ba2:	89 04 24             	mov    %eax,(%esp)
 ba5:	e8 32 f9 ff ff       	call   4dc <threadWake>
  }
  return;
 baa:	90                   	nop
}
 bab:	c9                   	leave  
 bac:	c3                   	ret    

00000bad <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 bad:	55                   	push   %ebp
 bae:	89 e5                	mov    %esp,%ebp
 bb0:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 bb3:	8b 45 08             	mov    0x8(%ebp),%eax
 bb6:	8b 55 10             	mov    0x10(%ebp),%edx
 bb9:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 bbb:	8b 45 08             	mov    0x8(%ebp),%eax
 bbe:	83 c0 04             	add    $0x4,%eax
 bc1:	89 04 24             	mov    %eax,(%esp)
 bc4:	e8 e2 fe ff ff       	call   aab <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 bc9:	8b 45 08             	mov    0x8(%ebp),%eax
 bcc:	83 c0 0c             	add    $0xc,%eax
 bcf:	89 04 24             	mov    %eax,(%esp)
 bd2:	e8 88 fe ff ff       	call   a5f <pthread_mutex_init>
  return;
 bd7:	90                   	nop
}
 bd8:	c9                   	leave  
 bd9:	c3                   	ret    

00000bda <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 bda:	55                   	push   %ebp
 bdb:	89 e5                	mov    %esp,%ebp
 bdd:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 be0:	8b 45 08             	mov    0x8(%ebp),%eax
 be3:	8b 00                	mov    (%eax),%eax
 be5:	8d 50 ff             	lea    -0x1(%eax),%edx
 be8:	8b 45 08             	mov    0x8(%ebp),%eax
 beb:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 bed:	8b 45 08             	mov    0x8(%ebp),%eax
 bf0:	8b 00                	mov    (%eax),%eax
 bf2:	85 c0                	test   %eax,%eax
 bf4:	79 18                	jns    c0e <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 bf6:	8b 45 08             	mov    0x8(%ebp),%eax
 bf9:	8d 50 0c             	lea    0xc(%eax),%edx
 bfc:	8b 45 08             	mov    0x8(%ebp),%eax
 bff:	83 c0 04             	add    $0x4,%eax
 c02:	89 54 24 04          	mov    %edx,0x4(%esp)
 c06:	89 04 24             	mov    %eax,(%esp)
 c09:	e8 b6 fe ff ff       	call   ac4 <pthread_cond_wait>
  }
  return;
 c0e:	90                   	nop
}
 c0f:	c9                   	leave  
 c10:	c3                   	ret    

00000c11 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 c11:	55                   	push   %ebp
 c12:	89 e5                	mov    %esp,%ebp
 c14:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 c17:	8b 45 08             	mov    0x8(%ebp),%eax
 c1a:	8b 00                	mov    (%eax),%eax
 c1c:	8d 50 01             	lea    0x1(%eax),%edx
 c1f:	8b 45 08             	mov    0x8(%ebp),%eax
 c22:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 c24:	8b 45 08             	mov    0x8(%ebp),%eax
 c27:	83 c0 04             	add    $0x4,%eax
 c2a:	89 04 24             	mov    %eax,(%esp)
 c2d:	e8 1e ff ff ff       	call   b50 <pthread_cond_signal>
  return;
 c32:	90                   	nop
}
 c33:	c9                   	leave  
 c34:	c3                   	ret    
