
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10:	00 
  11:	c7 04 24 97 0b 00 00 	movl   $0xb97,(%esp)
  18:	e8 9b 03 00 00       	call   3b8 <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 97 0b 00 00 	movl   $0xb97,(%esp)
  38:	e8 83 03 00 00       	call   3c0 <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 97 0b 00 00 	movl   $0xb97,(%esp)
  4c:	e8 67 03 00 00       	call   3b8 <open>
  }
  dup(0);  // stdout
  51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  58:	e8 93 03 00 00       	call   3f0 <dup>
  dup(0);  // stderr
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 87 03 00 00       	call   3f0 <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  69:	c7 44 24 04 9f 0b 00 	movl   $0xb9f,0x4(%esp)
  70:	00 
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 a3 04 00 00       	call   520 <printf>
    pid = fork();
  7d:	e8 ee 02 00 00       	call   370 <fork>
  82:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  86:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  8b:	79 19                	jns    a6 <main+0xa6>
      printf(1, "init: fork failed\n");
  8d:	c7 44 24 04 b2 0b 00 	movl   $0xbb2,0x4(%esp)
  94:	00 
  95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9c:	e8 7f 04 00 00       	call   520 <printf>
      exit();
  a1:	e8 d2 02 00 00       	call   378 <exit>
    }
    if(pid == 0){
  a6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  ab:	75 2d                	jne    da <main+0xda>
      exec("sh", argv);
  ad:	c7 44 24 04 e0 0f 00 	movl   $0xfe0,0x4(%esp)
  b4:	00 
  b5:	c7 04 24 94 0b 00 00 	movl   $0xb94,(%esp)
  bc:	e8 ef 02 00 00       	call   3b0 <exec>
      printf(1, "init: exec sh failed\n");
  c1:	c7 44 24 04 c5 0b 00 	movl   $0xbc5,0x4(%esp)
  c8:	00 
  c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d0:	e8 4b 04 00 00       	call   520 <printf>
      exit();
  d5:	e8 9e 02 00 00       	call   378 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  da:	eb 14                	jmp    f0 <main+0xf0>
      printf(1, "zombie!\n");
  dc:	c7 44 24 04 db 0b 00 	movl   $0xbdb,0x4(%esp)
  e3:	00 
  e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  eb:	e8 30 04 00 00       	call   520 <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  f0:	e8 8b 02 00 00       	call   380 <wait>
  f5:	89 44 24 18          	mov    %eax,0x18(%esp)
  f9:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  fe:	78 0a                	js     10a <main+0x10a>
 100:	8b 44 24 18          	mov    0x18(%esp),%eax
 104:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 108:	75 d2                	jne    dc <main+0xdc>
      printf(1, "zombie!\n");
  }
 10a:	e9 5a ff ff ff       	jmp    69 <main+0x69>
 10f:	90                   	nop

00000110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 115:	8b 4d 08             	mov    0x8(%ebp),%ecx
 118:	8b 55 10             	mov    0x10(%ebp),%edx
 11b:	8b 45 0c             	mov    0xc(%ebp),%eax
 11e:	89 cb                	mov    %ecx,%ebx
 120:	89 df                	mov    %ebx,%edi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld    
 125:	f3 aa                	rep stos %al,%es:(%edi)
 127:	89 ca                	mov    %ecx,%edx
 129:	89 fb                	mov    %edi,%ebx
 12b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 131:	5b                   	pop    %ebx
 132:	5f                   	pop    %edi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 141:	90                   	nop
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	8d 50 01             	lea    0x1(%eax),%edx
 148:	89 55 08             	mov    %edx,0x8(%ebp)
 14b:	8b 55 0c             	mov    0xc(%ebp),%edx
 14e:	8d 4a 01             	lea    0x1(%edx),%ecx
 151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 154:	0f b6 12             	movzbl (%edx),%edx
 157:	88 10                	mov    %dl,(%eax)
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	84 c0                	test   %al,%al
 15e:	75 e2                	jne    142 <strcpy+0xd>
    ;
  return os;
 160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 163:	c9                   	leave  
 164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 165:	55                   	push   %ebp
 166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
 16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	74 10                	je     18c <strcmp+0x27>
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	0f b6 10             	movzbl (%eax),%edx
 182:	8b 45 0c             	mov    0xc(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	38 c2                	cmp    %al,%dl
 18a:	74 de                	je     16a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 00             	movzbl (%eax),%eax
 192:	0f b6 d0             	movzbl %al,%edx
 195:	8b 45 0c             	mov    0xc(%ebp),%eax
 198:	0f b6 00             	movzbl (%eax),%eax
 19b:	0f b6 c0             	movzbl %al,%eax
 19e:	29 c2                	sub    %eax,%edx
 1a0:	89 d0                	mov    %edx,%eax
}
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    

000001a4 <strlen>:

uint
strlen(char *s)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b1:	eb 04                	jmp    1b7 <strlen+0x13>
 1b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	01 d0                	add    %edx,%eax
 1bf:	0f b6 00             	movzbl (%eax),%eax
 1c2:	84 c0                	test   %al,%al
 1c4:	75 ed                	jne    1b3 <strlen+0xf>
    ;
  return n;
 1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c9:	c9                   	leave  
 1ca:	c3                   	ret    

000001cb <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cb:	55                   	push   %ebp
 1cc:	89 e5                	mov    %esp,%ebp
 1ce:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1d1:	8b 45 10             	mov    0x10(%ebp),%eax
 1d4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1db:	89 44 24 04          	mov    %eax,0x4(%esp)
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	89 04 24             	mov    %eax,(%esp)
 1e5:	e8 26 ff ff ff       	call   110 <stosb>
  return dst;
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ed:	c9                   	leave  
 1ee:	c3                   	ret    

000001ef <strchr>:

char*
strchr(const char *s, char c)
{
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 04             	sub    $0x4,%esp
 1f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1fb:	eb 14                	jmp    211 <strchr+0x22>
    if(*s == c)
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	0f b6 00             	movzbl (%eax),%eax
 203:	3a 45 fc             	cmp    -0x4(%ebp),%al
 206:	75 05                	jne    20d <strchr+0x1e>
      return (char*)s;
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	eb 13                	jmp    220 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 20d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 211:	8b 45 08             	mov    0x8(%ebp),%eax
 214:	0f b6 00             	movzbl (%eax),%eax
 217:	84 c0                	test   %al,%al
 219:	75 e2                	jne    1fd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 21b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 220:	c9                   	leave  
 221:	c3                   	ret    

00000222 <gets>:

char*
gets(char *buf, int max)
{
 222:	55                   	push   %ebp
 223:	89 e5                	mov    %esp,%ebp
 225:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 228:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 22f:	eb 4c                	jmp    27d <gets+0x5b>
    cc = read(0, &c, 1);
 231:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 238:	00 
 239:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23c:	89 44 24 04          	mov    %eax,0x4(%esp)
 240:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 247:	e8 44 01 00 00       	call   390 <read>
 24c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 253:	7f 02                	jg     257 <gets+0x35>
      break;
 255:	eb 31                	jmp    288 <gets+0x66>
    buf[i++] = c;
 257:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25a:	8d 50 01             	lea    0x1(%eax),%edx
 25d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 260:	89 c2                	mov    %eax,%edx
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	01 c2                	add    %eax,%edx
 267:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 271:	3c 0a                	cmp    $0xa,%al
 273:	74 13                	je     288 <gets+0x66>
 275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 279:	3c 0d                	cmp    $0xd,%al
 27b:	74 0b                	je     288 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 280:	83 c0 01             	add    $0x1,%eax
 283:	3b 45 0c             	cmp    0xc(%ebp),%eax
 286:	7c a9                	jl     231 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 288:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	01 d0                	add    %edx,%eax
 290:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 293:	8b 45 08             	mov    0x8(%ebp),%eax
}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <stat>:

int
stat(char *n, struct stat *st)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a5:	00 
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	89 04 24             	mov    %eax,(%esp)
 2ac:	e8 07 01 00 00       	call   3b8 <open>
 2b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b8:	79 07                	jns    2c1 <stat+0x29>
    return -1;
 2ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bf:	eb 23                	jmp    2e4 <stat+0x4c>
  r = fstat(fd, st);
 2c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2cb:	89 04 24             	mov    %eax,(%esp)
 2ce:	e8 fd 00 00 00       	call   3d0 <fstat>
 2d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d9:	89 04 24             	mov    %eax,(%esp)
 2dc:	e8 bf 00 00 00       	call   3a0 <close>
  return r;
 2e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e4:	c9                   	leave  
 2e5:	c3                   	ret    

000002e6 <atoi>:

int
atoi(const char *s)
{
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f3:	eb 25                	jmp    31a <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f8:	89 d0                	mov    %edx,%eax
 2fa:	c1 e0 02             	shl    $0x2,%eax
 2fd:	01 d0                	add    %edx,%eax
 2ff:	01 c0                	add    %eax,%eax
 301:	89 c1                	mov    %eax,%ecx
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	8d 50 01             	lea    0x1(%eax),%edx
 309:	89 55 08             	mov    %edx,0x8(%ebp)
 30c:	0f b6 00             	movzbl (%eax),%eax
 30f:	0f be c0             	movsbl %al,%eax
 312:	01 c8                	add    %ecx,%eax
 314:	83 e8 30             	sub    $0x30,%eax
 317:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31a:	8b 45 08             	mov    0x8(%ebp),%eax
 31d:	0f b6 00             	movzbl (%eax),%eax
 320:	3c 2f                	cmp    $0x2f,%al
 322:	7e 0a                	jle    32e <atoi+0x48>
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	0f b6 00             	movzbl (%eax),%eax
 32a:	3c 39                	cmp    $0x39,%al
 32c:	7e c7                	jle    2f5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 32e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 333:	55                   	push   %ebp
 334:	89 e5                	mov    %esp,%ebp
 336:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 339:	8b 45 08             	mov    0x8(%ebp),%eax
 33c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33f:	8b 45 0c             	mov    0xc(%ebp),%eax
 342:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 345:	eb 17                	jmp    35e <memmove+0x2b>
    *dst++ = *src++;
 347:	8b 45 fc             	mov    -0x4(%ebp),%eax
 34a:	8d 50 01             	lea    0x1(%eax),%edx
 34d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 350:	8b 55 f8             	mov    -0x8(%ebp),%edx
 353:	8d 4a 01             	lea    0x1(%edx),%ecx
 356:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 359:	0f b6 12             	movzbl (%edx),%edx
 35c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	8b 45 10             	mov    0x10(%ebp),%eax
 361:	8d 50 ff             	lea    -0x1(%eax),%edx
 364:	89 55 10             	mov    %edx,0x10(%ebp)
 367:	85 c0                	test   %eax,%eax
 369:	7f dc                	jg     347 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36e:	c9                   	leave  
 36f:	c3                   	ret    

00000370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 370:	b8 01 00 00 00       	mov    $0x1,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exit>:
SYSCALL(exit)
 378:	b8 02 00 00 00       	mov    $0x2,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <wait>:
SYSCALL(wait)
 380:	b8 03 00 00 00       	mov    $0x3,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <pipe>:
SYSCALL(pipe)
 388:	b8 04 00 00 00       	mov    $0x4,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <read>:
SYSCALL(read)
 390:	b8 05 00 00 00       	mov    $0x5,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <write>:
SYSCALL(write)
 398:	b8 10 00 00 00       	mov    $0x10,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <close>:
SYSCALL(close)
 3a0:	b8 15 00 00 00       	mov    $0x15,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kill>:
SYSCALL(kill)
 3a8:	b8 06 00 00 00       	mov    $0x6,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <exec>:
SYSCALL(exec)
 3b0:	b8 07 00 00 00       	mov    $0x7,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <open>:
SYSCALL(open)
 3b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <mknod>:
SYSCALL(mknod)
 3c0:	b8 11 00 00 00       	mov    $0x11,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <unlink>:
SYSCALL(unlink)
 3c8:	b8 12 00 00 00       	mov    $0x12,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <fstat>:
SYSCALL(fstat)
 3d0:	b8 08 00 00 00       	mov    $0x8,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <link>:
SYSCALL(link)
 3d8:	b8 13 00 00 00       	mov    $0x13,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <mkdir>:
SYSCALL(mkdir)
 3e0:	b8 14 00 00 00       	mov    $0x14,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <chdir>:
SYSCALL(chdir)
 3e8:	b8 09 00 00 00       	mov    $0x9,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <dup>:
SYSCALL(dup)
 3f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <getpid>:
SYSCALL(getpid)
 3f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <sbrk>:
SYSCALL(sbrk)
 400:	b8 0c 00 00 00       	mov    $0xc,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <sleep>:
SYSCALL(sleep)
 408:	b8 0d 00 00 00       	mov    $0xd,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <uptime>:
SYSCALL(uptime)
 410:	b8 0e 00 00 00       	mov    $0xe,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <date>:
SYSCALL(date)
 418:	b8 16 00 00 00       	mov    $0x16,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <clone>:
SYSCALL(clone)
 420:	b8 17 00 00 00       	mov    $0x17,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <join>:
SYSCALL(join)
 428:	b8 18 00 00 00       	mov    $0x18,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <threadSleep>:
SYSCALL(threadSleep)
 430:	b8 19 00 00 00       	mov    $0x19,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <threadWake>:
SYSCALL(threadWake)
 438:	b8 1a 00 00 00       	mov    $0x1a,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	83 ec 18             	sub    $0x18,%esp
 446:	8b 45 0c             	mov    0xc(%ebp),%eax
 449:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 44c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 453:	00 
 454:	8d 45 f4             	lea    -0xc(%ebp),%eax
 457:	89 44 24 04          	mov    %eax,0x4(%esp)
 45b:	8b 45 08             	mov    0x8(%ebp),%eax
 45e:	89 04 24             	mov    %eax,(%esp)
 461:	e8 32 ff ff ff       	call   398 <write>
}
 466:	c9                   	leave  
 467:	c3                   	ret    

00000468 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 468:	55                   	push   %ebp
 469:	89 e5                	mov    %esp,%ebp
 46b:	56                   	push   %esi
 46c:	53                   	push   %ebx
 46d:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 470:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 477:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 47b:	74 17                	je     494 <printint+0x2c>
 47d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 481:	79 11                	jns    494 <printint+0x2c>
    neg = 1;
 483:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 48a:	8b 45 0c             	mov    0xc(%ebp),%eax
 48d:	f7 d8                	neg    %eax
 48f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 492:	eb 06                	jmp    49a <printint+0x32>
  } else {
    x = xx;
 494:	8b 45 0c             	mov    0xc(%ebp),%eax
 497:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 49a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4a4:	8d 41 01             	lea    0x1(%ecx),%eax
 4a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4aa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b0:	ba 00 00 00 00       	mov    $0x0,%edx
 4b5:	f7 f3                	div    %ebx
 4b7:	89 d0                	mov    %edx,%eax
 4b9:	0f b6 80 e8 0f 00 00 	movzbl 0xfe8(%eax),%eax
 4c0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4c4:	8b 75 10             	mov    0x10(%ebp),%esi
 4c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4ca:	ba 00 00 00 00       	mov    $0x0,%edx
 4cf:	f7 f6                	div    %esi
 4d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d8:	75 c7                	jne    4a1 <printint+0x39>
  if(neg)
 4da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4de:	74 10                	je     4f0 <printint+0x88>
    buf[i++] = '-';
 4e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e3:	8d 50 01             	lea    0x1(%eax),%edx
 4e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4e9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4ee:	eb 1f                	jmp    50f <printint+0xa7>
 4f0:	eb 1d                	jmp    50f <printint+0xa7>
    putc(fd, buf[i]);
 4f2:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f8:	01 d0                	add    %edx,%eax
 4fa:	0f b6 00             	movzbl (%eax),%eax
 4fd:	0f be c0             	movsbl %al,%eax
 500:	89 44 24 04          	mov    %eax,0x4(%esp)
 504:	8b 45 08             	mov    0x8(%ebp),%eax
 507:	89 04 24             	mov    %eax,(%esp)
 50a:	e8 31 ff ff ff       	call   440 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 50f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 517:	79 d9                	jns    4f2 <printint+0x8a>
    putc(fd, buf[i]);
}
 519:	83 c4 30             	add    $0x30,%esp
 51c:	5b                   	pop    %ebx
 51d:	5e                   	pop    %esi
 51e:	5d                   	pop    %ebp
 51f:	c3                   	ret    

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 526:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 52d:	8d 45 0c             	lea    0xc(%ebp),%eax
 530:	83 c0 04             	add    $0x4,%eax
 533:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 536:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 53d:	e9 7c 01 00 00       	jmp    6be <printf+0x19e>
    c = fmt[i] & 0xff;
 542:	8b 55 0c             	mov    0xc(%ebp),%edx
 545:	8b 45 f0             	mov    -0x10(%ebp),%eax
 548:	01 d0                	add    %edx,%eax
 54a:	0f b6 00             	movzbl (%eax),%eax
 54d:	0f be c0             	movsbl %al,%eax
 550:	25 ff 00 00 00       	and    $0xff,%eax
 555:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 558:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 55c:	75 2c                	jne    58a <printf+0x6a>
      if(c == '%'){
 55e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 562:	75 0c                	jne    570 <printf+0x50>
        state = '%';
 564:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 56b:	e9 4a 01 00 00       	jmp    6ba <printf+0x19a>
      } else {
        putc(fd, c);
 570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 573:	0f be c0             	movsbl %al,%eax
 576:	89 44 24 04          	mov    %eax,0x4(%esp)
 57a:	8b 45 08             	mov    0x8(%ebp),%eax
 57d:	89 04 24             	mov    %eax,(%esp)
 580:	e8 bb fe ff ff       	call   440 <putc>
 585:	e9 30 01 00 00       	jmp    6ba <printf+0x19a>
      }
    } else if(state == '%'){
 58a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 58e:	0f 85 26 01 00 00    	jne    6ba <printf+0x19a>
      if(c == 'd'){
 594:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 598:	75 2d                	jne    5c7 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 59a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59d:	8b 00                	mov    (%eax),%eax
 59f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5a6:	00 
 5a7:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5ae:	00 
 5af:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b3:	8b 45 08             	mov    0x8(%ebp),%eax
 5b6:	89 04 24             	mov    %eax,(%esp)
 5b9:	e8 aa fe ff ff       	call   468 <printint>
        ap++;
 5be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c2:	e9 ec 00 00 00       	jmp    6b3 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5c7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5cb:	74 06                	je     5d3 <printf+0xb3>
 5cd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5d1:	75 2d                	jne    600 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d6:	8b 00                	mov    (%eax),%eax
 5d8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5df:	00 
 5e0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5e7:	00 
 5e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	89 04 24             	mov    %eax,(%esp)
 5f2:	e8 71 fe ff ff       	call   468 <printint>
        ap++;
 5f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fb:	e9 b3 00 00 00       	jmp    6b3 <printf+0x193>
      } else if(c == 's'){
 600:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 604:	75 45                	jne    64b <printf+0x12b>
        s = (char*)*ap;
 606:	8b 45 e8             	mov    -0x18(%ebp),%eax
 609:	8b 00                	mov    (%eax),%eax
 60b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 60e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 612:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 616:	75 09                	jne    621 <printf+0x101>
          s = "(null)";
 618:	c7 45 f4 e4 0b 00 00 	movl   $0xbe4,-0xc(%ebp)
        while(*s != 0){
 61f:	eb 1e                	jmp    63f <printf+0x11f>
 621:	eb 1c                	jmp    63f <printf+0x11f>
          putc(fd, *s);
 623:	8b 45 f4             	mov    -0xc(%ebp),%eax
 626:	0f b6 00             	movzbl (%eax),%eax
 629:	0f be c0             	movsbl %al,%eax
 62c:	89 44 24 04          	mov    %eax,0x4(%esp)
 630:	8b 45 08             	mov    0x8(%ebp),%eax
 633:	89 04 24             	mov    %eax,(%esp)
 636:	e8 05 fe ff ff       	call   440 <putc>
          s++;
 63b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 63f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 642:	0f b6 00             	movzbl (%eax),%eax
 645:	84 c0                	test   %al,%al
 647:	75 da                	jne    623 <printf+0x103>
 649:	eb 68                	jmp    6b3 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 64f:	75 1d                	jne    66e <printf+0x14e>
        putc(fd, *ap);
 651:	8b 45 e8             	mov    -0x18(%ebp),%eax
 654:	8b 00                	mov    (%eax),%eax
 656:	0f be c0             	movsbl %al,%eax
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
 660:	89 04 24             	mov    %eax,(%esp)
 663:	e8 d8 fd ff ff       	call   440 <putc>
        ap++;
 668:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 66c:	eb 45                	jmp    6b3 <printf+0x193>
      } else if(c == '%'){
 66e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 672:	75 17                	jne    68b <printf+0x16b>
        putc(fd, c);
 674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 677:	0f be c0             	movsbl %al,%eax
 67a:	89 44 24 04          	mov    %eax,0x4(%esp)
 67e:	8b 45 08             	mov    0x8(%ebp),%eax
 681:	89 04 24             	mov    %eax,(%esp)
 684:	e8 b7 fd ff ff       	call   440 <putc>
 689:	eb 28                	jmp    6b3 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 68b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 692:	00 
 693:	8b 45 08             	mov    0x8(%ebp),%eax
 696:	89 04 24             	mov    %eax,(%esp)
 699:	e8 a2 fd ff ff       	call   440 <putc>
        putc(fd, c);
 69e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a1:	0f be c0             	movsbl %al,%eax
 6a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a8:	8b 45 08             	mov    0x8(%ebp),%eax
 6ab:	89 04 24             	mov    %eax,(%esp)
 6ae:	e8 8d fd ff ff       	call   440 <putc>
      }
      state = 0;
 6b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6be:	8b 55 0c             	mov    0xc(%ebp),%edx
 6c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c4:	01 d0                	add    %edx,%eax
 6c6:	0f b6 00             	movzbl (%eax),%eax
 6c9:	84 c0                	test   %al,%al
 6cb:	0f 85 71 fe ff ff    	jne    542 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6d1:	c9                   	leave  
 6d2:	c3                   	ret    
 6d3:	90                   	nop

000006d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d4:	55                   	push   %ebp
 6d5:	89 e5                	mov    %esp,%ebp
 6d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6da:	8b 45 08             	mov    0x8(%ebp),%eax
 6dd:	83 e8 08             	sub    $0x8,%eax
 6e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e3:	a1 04 10 00 00       	mov    0x1004,%eax
 6e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6eb:	eb 24                	jmp    711 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	8b 00                	mov    (%eax),%eax
 6f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f5:	77 12                	ja     709 <free+0x35>
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6fd:	77 24                	ja     723 <free+0x4f>
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	8b 00                	mov    (%eax),%eax
 704:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 707:	77 1a                	ja     723 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 00                	mov    (%eax),%eax
 70e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 717:	76 d4                	jbe    6ed <free+0x19>
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 00                	mov    (%eax),%eax
 71e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 721:	76 ca                	jbe    6ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 723:	8b 45 f8             	mov    -0x8(%ebp),%eax
 726:	8b 40 04             	mov    0x4(%eax),%eax
 729:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 730:	8b 45 f8             	mov    -0x8(%ebp),%eax
 733:	01 c2                	add    %eax,%edx
 735:	8b 45 fc             	mov    -0x4(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	39 c2                	cmp    %eax,%edx
 73c:	75 24                	jne    762 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 73e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 741:	8b 50 04             	mov    0x4(%eax),%edx
 744:	8b 45 fc             	mov    -0x4(%ebp),%eax
 747:	8b 00                	mov    (%eax),%eax
 749:	8b 40 04             	mov    0x4(%eax),%eax
 74c:	01 c2                	add    %eax,%edx
 74e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 751:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 00                	mov    (%eax),%eax
 759:	8b 10                	mov    (%eax),%edx
 75b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75e:	89 10                	mov    %edx,(%eax)
 760:	eb 0a                	jmp    76c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 762:	8b 45 fc             	mov    -0x4(%ebp),%eax
 765:	8b 10                	mov    (%eax),%edx
 767:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 76c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76f:	8b 40 04             	mov    0x4(%eax),%eax
 772:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 779:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77c:	01 d0                	add    %edx,%eax
 77e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 781:	75 20                	jne    7a3 <free+0xcf>
    p->s.size += bp->s.size;
 783:	8b 45 fc             	mov    -0x4(%ebp),%eax
 786:	8b 50 04             	mov    0x4(%eax),%edx
 789:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78c:	8b 40 04             	mov    0x4(%eax),%eax
 78f:	01 c2                	add    %eax,%edx
 791:	8b 45 fc             	mov    -0x4(%ebp),%eax
 794:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 797:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79a:	8b 10                	mov    (%eax),%edx
 79c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79f:	89 10                	mov    %edx,(%eax)
 7a1:	eb 08                	jmp    7ab <free+0xd7>
  } else
    p->s.ptr = bp;
 7a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7a9:	89 10                	mov    %edx,(%eax)
  freep = p;
 7ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ae:	a3 04 10 00 00       	mov    %eax,0x1004
}
 7b3:	c9                   	leave  
 7b4:	c3                   	ret    

000007b5 <morecore>:

static Header*
morecore(uint nu)
{
 7b5:	55                   	push   %ebp
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7bb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7c2:	77 07                	ja     7cb <morecore+0x16>
    nu = 4096;
 7c4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7cb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ce:	c1 e0 03             	shl    $0x3,%eax
 7d1:	89 04 24             	mov    %eax,(%esp)
 7d4:	e8 27 fc ff ff       	call   400 <sbrk>
 7d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7dc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7e0:	75 07                	jne    7e9 <morecore+0x34>
    return 0;
 7e2:	b8 00 00 00 00       	mov    $0x0,%eax
 7e7:	eb 22                	jmp    80b <morecore+0x56>
  hp = (Header*)p;
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f2:	8b 55 08             	mov    0x8(%ebp),%edx
 7f5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fb:	83 c0 08             	add    $0x8,%eax
 7fe:	89 04 24             	mov    %eax,(%esp)
 801:	e8 ce fe ff ff       	call   6d4 <free>
  return freep;
 806:	a1 04 10 00 00       	mov    0x1004,%eax
}
 80b:	c9                   	leave  
 80c:	c3                   	ret    

0000080d <malloc>:

void*
malloc(uint nbytes)
{
 80d:	55                   	push   %ebp
 80e:	89 e5                	mov    %esp,%ebp
 810:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 813:	8b 45 08             	mov    0x8(%ebp),%eax
 816:	83 c0 07             	add    $0x7,%eax
 819:	c1 e8 03             	shr    $0x3,%eax
 81c:	83 c0 01             	add    $0x1,%eax
 81f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 822:	a1 04 10 00 00       	mov    0x1004,%eax
 827:	89 45 f0             	mov    %eax,-0x10(%ebp)
 82a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 82e:	75 23                	jne    853 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 830:	c7 45 f0 fc 0f 00 00 	movl   $0xffc,-0x10(%ebp)
 837:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83a:	a3 04 10 00 00       	mov    %eax,0x1004
 83f:	a1 04 10 00 00       	mov    0x1004,%eax
 844:	a3 fc 0f 00 00       	mov    %eax,0xffc
    base.s.size = 0;
 849:	c7 05 00 10 00 00 00 	movl   $0x0,0x1000
 850:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 853:	8b 45 f0             	mov    -0x10(%ebp),%eax
 856:	8b 00                	mov    (%eax),%eax
 858:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 85b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85e:	8b 40 04             	mov    0x4(%eax),%eax
 861:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 864:	72 4d                	jb     8b3 <malloc+0xa6>
      if(p->s.size == nunits)
 866:	8b 45 f4             	mov    -0xc(%ebp),%eax
 869:	8b 40 04             	mov    0x4(%eax),%eax
 86c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 86f:	75 0c                	jne    87d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	8b 10                	mov    (%eax),%edx
 876:	8b 45 f0             	mov    -0x10(%ebp),%eax
 879:	89 10                	mov    %edx,(%eax)
 87b:	eb 26                	jmp    8a3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 880:	8b 40 04             	mov    0x4(%eax),%eax
 883:	2b 45 ec             	sub    -0x14(%ebp),%eax
 886:	89 c2                	mov    %eax,%edx
 888:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 88e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 891:	8b 40 04             	mov    0x4(%eax),%eax
 894:	c1 e0 03             	shl    $0x3,%eax
 897:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8a0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a6:	a3 04 10 00 00       	mov    %eax,0x1004
      return (void*)(p + 1);
 8ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ae:	83 c0 08             	add    $0x8,%eax
 8b1:	eb 38                	jmp    8eb <malloc+0xde>
    }
    if(p == freep)
 8b3:	a1 04 10 00 00       	mov    0x1004,%eax
 8b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8bb:	75 1b                	jne    8d8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8c0:	89 04 24             	mov    %eax,(%esp)
 8c3:	e8 ed fe ff ff       	call   7b5 <morecore>
 8c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8cf:	75 07                	jne    8d8 <malloc+0xcb>
        return 0;
 8d1:	b8 00 00 00 00       	mov    $0x0,%eax
 8d6:	eb 13                	jmp    8eb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8db:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e1:	8b 00                	mov    (%eax),%eax
 8e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8e6:	e9 70 ff ff ff       	jmp    85b <malloc+0x4e>
}
 8eb:	c9                   	leave  
 8ec:	c3                   	ret    
 8ed:	66 90                	xchg   %ax,%ax
 8ef:	90                   	nop

000008f0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 8f6:	8b 55 08             	mov    0x8(%ebp),%edx
 8f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 8fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8ff:	f0 87 02             	lock xchg %eax,(%edx)
 902:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 905:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 908:	c9                   	leave  
 909:	c3                   	ret    

0000090a <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 90a:	55                   	push   %ebp
 90b:	89 e5                	mov    %esp,%ebp
 90d:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 910:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 917:	e8 f1 fe ff ff       	call   80d <malloc>
 91c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 91f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 922:	85 c0                	test   %eax,%eax
 924:	75 1b                	jne    941 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 926:	c7 44 24 04 ec 0b 00 	movl   $0xbec,0x4(%esp)
 92d:	00 
 92e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 935:	e8 e6 fb ff ff       	call   520 <printf>
    return -1;
 93a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 93f:	eb 43                	jmp    984 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 941:	8b 45 f4             	mov    -0xc(%ebp),%eax
 944:	25 ff 0f 00 00       	and    $0xfff,%eax
 949:	85 c0                	test   %eax,%eax
 94b:	74 14                	je     961 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 94d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 950:	25 ff 0f 00 00       	and    $0xfff,%eax
 955:	89 c2                	mov    %eax,%edx
 957:	b8 00 10 00 00       	mov    $0x1000,%eax
 95c:	29 d0                	sub    %edx,%eax
 95e:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 961:	8b 45 f4             	mov    -0xc(%ebp),%eax
 964:	89 44 24 08          	mov    %eax,0x8(%esp)
 968:	8b 45 14             	mov    0x14(%ebp),%eax
 96b:	89 44 24 04          	mov    %eax,0x4(%esp)
 96f:	8b 45 10             	mov    0x10(%ebp),%eax
 972:	89 04 24             	mov    %eax,(%esp)
 975:	e8 a6 fa ff ff       	call   420 <clone>
 97a:	8b 55 08             	mov    0x8(%ebp),%edx
 97d:	89 02                	mov    %eax,(%edx)
  return *thread;
 97f:	8b 45 08             	mov    0x8(%ebp),%eax
 982:	8b 00                	mov    (%eax),%eax
}
 984:	c9                   	leave  
 985:	c3                   	ret    

00000986 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 986:	55                   	push   %ebp
 987:	89 e5                	mov    %esp,%ebp
 989:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 98c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 98f:	89 44 24 04          	mov    %eax,0x4(%esp)
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	89 04 24             	mov    %eax,(%esp)
 999:	e8 8a fa ff ff       	call   428 <join>
 99e:	85 c0                	test   %eax,%eax
 9a0:	79 07                	jns    9a9 <pthread_join+0x23>
    return -1;
 9a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9a7:	eb 10                	jmp    9b9 <pthread_join+0x33>
  }
  free(stack);
 9a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ac:	89 04 24             	mov    %eax,(%esp)
 9af:	e8 20 fd ff ff       	call   6d4 <free>
  return 0;
 9b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b9:	c9                   	leave  
 9ba:	c3                   	ret    

000009bb <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 9bb:	55                   	push   %ebp
 9bc:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 9be:	8b 45 08             	mov    0x8(%ebp),%eax
 9c1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 9c7:	90                   	nop
}
 9c8:	5d                   	pop    %ebp
 9c9:	c3                   	ret    

000009ca <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 9ca:	55                   	push   %ebp
 9cb:	89 e5                	mov    %esp,%ebp
 9cd:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 9d0:	90                   	nop
 9d1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 9d8:	00 
 9d9:	8b 45 08             	mov    0x8(%ebp),%eax
 9dc:	89 04 24             	mov    %eax,(%esp)
 9df:	e8 0c ff ff ff       	call   8f0 <xchg>
 9e4:	85 c0                	test   %eax,%eax
 9e6:	75 e9                	jne    9d1 <pthread_mutex_lock+0x7>
  return;
 9e8:	90                   	nop
}
 9e9:	c9                   	leave  
 9ea:	c3                   	ret    

000009eb <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 9eb:	55                   	push   %ebp
 9ec:	89 e5                	mov    %esp,%ebp
 9ee:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 9f1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 9f8:	00 
 9f9:	8b 45 08             	mov    0x8(%ebp),%eax
 9fc:	89 04 24             	mov    %eax,(%esp)
 9ff:	e8 ec fe ff ff       	call   8f0 <xchg>
  return;
 a04:	90                   	nop
}
 a05:	c9                   	leave  
 a06:	c3                   	ret    

00000a07 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 a07:	55                   	push   %ebp
 a08:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 a0a:	8b 45 08             	mov    0x8(%ebp),%eax
 a0d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 a13:	8b 45 08             	mov    0x8(%ebp),%eax
 a16:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 a1d:	90                   	nop
}
 a1e:	5d                   	pop    %ebp
 a1f:	c3                   	ret    

00000a20 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
 a23:	53                   	push   %ebx
 a24:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 a27:	8b 45 08             	mov    0x8(%ebp),%eax
 a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
 a30:	89 04 24             	mov    %eax,(%esp)
 a33:	e8 b3 ff ff ff       	call   9eb <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 a38:	eb 09                	jmp    a43 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3d:	8b 40 04             	mov    0x4(%eax),%eax
 a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a46:	8b 40 04             	mov    0x4(%eax),%eax
 a49:	85 c0                	test   %eax,%eax
 a4b:	75 ed                	jne    a3a <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 a4d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 a54:	e8 b4 fd ff ff       	call   80d <malloc>
 a59:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a5c:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a62:	8b 58 04             	mov    0x4(%eax),%ebx
 a65:	e8 8e f9 ff ff       	call   3f8 <getpid>
 a6a:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6f:	8b 40 04             	mov    0x4(%eax),%eax
 a72:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 a79:	8b 45 0c             	mov    0xc(%ebp),%eax
 a7c:	89 04 24             	mov    %eax,(%esp)
 a7f:	e8 46 ff ff ff       	call   9ca <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 a84:	8b 45 0c             	mov    0xc(%ebp),%eax
 a87:	89 04 24             	mov    %eax,(%esp)
 a8a:	e8 5c ff ff ff       	call   9eb <pthread_mutex_unlock>
  threadSleep(mutex);
 a8f:	8b 45 0c             	mov    0xc(%ebp),%eax
 a92:	89 04 24             	mov    %eax,(%esp)
 a95:	e8 96 f9 ff ff       	call   430 <threadSleep>
  pthread_mutex_lock(mutex);
 a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
 a9d:	89 04 24             	mov    %eax,(%esp)
 aa0:	e8 25 ff ff ff       	call   9ca <pthread_mutex_lock>
  return;
 aa5:	90                   	nop
}
 aa6:	83 c4 24             	add    $0x24,%esp
 aa9:	5b                   	pop    %ebx
 aaa:	5d                   	pop    %ebp
 aab:	c3                   	ret    

00000aac <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 aac:	55                   	push   %ebp
 aad:	89 e5                	mov    %esp,%ebp
 aaf:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 ab2:	8b 45 08             	mov    0x8(%ebp),%eax
 ab5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 ab8:	eb 09                	jmp    ac3 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abd:	8b 40 04             	mov    0x4(%eax),%eax
 ac0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 ac3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac6:	8b 00                	mov    (%eax),%eax
 ac8:	83 f8 ff             	cmp    $0xffffffff,%eax
 acb:	74 ed                	je     aba <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 acd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ad1:	74 33                	je     b06 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad6:	8b 00                	mov    (%eax),%eax
 ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ade:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 ae1:	8b 45 08             	mov    0x8(%ebp),%eax
 ae4:	8b 40 04             	mov    0x4(%eax),%eax
 ae7:	8b 50 04             	mov    0x4(%eax),%edx
 aea:	8b 45 08             	mov    0x8(%ebp),%eax
 aed:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 af0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 af3:	89 04 24             	mov    %eax,(%esp)
 af6:	e8 d9 fb ff ff       	call   6d4 <free>
    threadWake(threadId);
 afb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 afe:	89 04 24             	mov    %eax,(%esp)
 b01:	e8 32 f9 ff ff       	call   438 <threadWake>
  }
  return;
 b06:	90                   	nop
}
 b07:	c9                   	leave  
 b08:	c3                   	ret    

00000b09 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 b09:	55                   	push   %ebp
 b0a:	89 e5                	mov    %esp,%ebp
 b0c:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 b0f:	8b 45 08             	mov    0x8(%ebp),%eax
 b12:	8b 55 10             	mov    0x10(%ebp),%edx
 b15:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 b17:	8b 45 08             	mov    0x8(%ebp),%eax
 b1a:	83 c0 04             	add    $0x4,%eax
 b1d:	89 04 24             	mov    %eax,(%esp)
 b20:	e8 e2 fe ff ff       	call   a07 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 b25:	8b 45 08             	mov    0x8(%ebp),%eax
 b28:	83 c0 0c             	add    $0xc,%eax
 b2b:	89 04 24             	mov    %eax,(%esp)
 b2e:	e8 88 fe ff ff       	call   9bb <pthread_mutex_init>
  return;
 b33:	90                   	nop
}
 b34:	c9                   	leave  
 b35:	c3                   	ret    

00000b36 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 b36:	55                   	push   %ebp
 b37:	89 e5                	mov    %esp,%ebp
 b39:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 b3c:	8b 45 08             	mov    0x8(%ebp),%eax
 b3f:	8b 00                	mov    (%eax),%eax
 b41:	8d 50 ff             	lea    -0x1(%eax),%edx
 b44:	8b 45 08             	mov    0x8(%ebp),%eax
 b47:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 b49:	8b 45 08             	mov    0x8(%ebp),%eax
 b4c:	8b 00                	mov    (%eax),%eax
 b4e:	85 c0                	test   %eax,%eax
 b50:	79 18                	jns    b6a <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 b52:	8b 45 08             	mov    0x8(%ebp),%eax
 b55:	8d 50 0c             	lea    0xc(%eax),%edx
 b58:	8b 45 08             	mov    0x8(%ebp),%eax
 b5b:	83 c0 04             	add    $0x4,%eax
 b5e:	89 54 24 04          	mov    %edx,0x4(%esp)
 b62:	89 04 24             	mov    %eax,(%esp)
 b65:	e8 b6 fe ff ff       	call   a20 <pthread_cond_wait>
  }
  return;
 b6a:	90                   	nop
}
 b6b:	c9                   	leave  
 b6c:	c3                   	ret    

00000b6d <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 b6d:	55                   	push   %ebp
 b6e:	89 e5                	mov    %esp,%ebp
 b70:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 b73:	8b 45 08             	mov    0x8(%ebp),%eax
 b76:	8b 00                	mov    (%eax),%eax
 b78:	8d 50 01             	lea    0x1(%eax),%edx
 b7b:	8b 45 08             	mov    0x8(%ebp),%eax
 b7e:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 b80:	8b 45 08             	mov    0x8(%ebp),%eax
 b83:	83 c0 04             	add    $0x4,%eax
 b86:	89 04 24             	mov    %eax,(%esp)
 b89:	e8 1e ff ff ff       	call   aac <pthread_cond_signal>
  return;
 b8e:	90                   	nop
}
 b8f:	c9                   	leave  
 b90:	c3                   	ret    
