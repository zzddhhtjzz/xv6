
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 48             	sub    $0x48,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 68                	jmp    8a <wc+0x8a>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 57                	jmp    82 <wc+0x82>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 00 11 00 00       	add    $0x1100,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 00 11 00 00       	add    $0x1100,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	89 44 24 04          	mov    %eax,0x4(%esp)
  54:	c7 04 24 60 0c 00 00 	movl   $0xc60,(%esp)
  5b:	e8 5b 02 00 00       	call   2bb <strchr>
  60:	85 c0                	test   %eax,%eax
  62:	74 09                	je     6d <wc+0x6d>
        inword = 0;
  64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6b:	eb 11                	jmp    7e <wc+0x7e>
      else if(!inword){
  6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  71:	75 0b                	jne    7e <wc+0x7e>
        w++;
  73:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  77:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  82:	8b 45 f4             	mov    -0xc(%ebp),%eax
  85:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  88:	7c a1                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  91:	00 
  92:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
  99:	00 
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 b7 03 00 00       	call   45c <read>
  a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  ac:	0f 8f 70 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b6:	79 19                	jns    d1 <wc+0xd1>
    printf(1, "wc: read error\n");
  b8:	c7 44 24 04 66 0c 00 	movl   $0xc66,0x4(%esp)
  bf:	00 
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 20 05 00 00       	call   5ec <printf>
    exit();
  cc:	e8 73 03 00 00       	call   444 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  d4:	89 44 24 14          	mov    %eax,0x14(%esp)
  d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  db:	89 44 24 10          	mov    %eax,0x10(%esp)
  df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ed:	c7 44 24 04 76 0c 00 	movl   $0xc76,0x4(%esp)
  f4:	00 
  f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fc:	e8 eb 04 00 00       	call   5ec <printf>
}
 101:	c9                   	leave  
 102:	c3                   	ret    

00000103 <main>:

int
main(int argc, char *argv[])
{
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	83 e4 f0             	and    $0xfffffff0,%esp
 109:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
 10c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 110:	7f 19                	jg     12b <main+0x28>
    wc(0, "");
 112:	c7 44 24 04 83 0c 00 	movl   $0xc83,0x4(%esp)
 119:	00 
 11a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 121:	e8 da fe ff ff       	call   0 <wc>
    exit();
 126:	e8 19 03 00 00       	call   444 <exit>
  }

  for(i = 1; i < argc; i++){
 12b:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 132:	00 
 133:	e9 8f 00 00 00       	jmp    1c7 <main+0xc4>
    if((fd = open(argv[i], 0)) < 0){
 138:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 13c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 143:	8b 45 0c             	mov    0xc(%ebp),%eax
 146:	01 d0                	add    %edx,%eax
 148:	8b 00                	mov    (%eax),%eax
 14a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 151:	00 
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 2a 03 00 00       	call   484 <open>
 15a:	89 44 24 18          	mov    %eax,0x18(%esp)
 15e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
 163:	79 2f                	jns    194 <main+0x91>
      printf(1, "wc: cannot open %s\n", argv[i]);
 165:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 169:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 170:	8b 45 0c             	mov    0xc(%ebp),%eax
 173:	01 d0                	add    %edx,%eax
 175:	8b 00                	mov    (%eax),%eax
 177:	89 44 24 08          	mov    %eax,0x8(%esp)
 17b:	c7 44 24 04 84 0c 00 	movl   $0xc84,0x4(%esp)
 182:	00 
 183:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18a:	e8 5d 04 00 00       	call   5ec <printf>
      exit();
 18f:	e8 b0 02 00 00       	call   444 <exit>
    }
    wc(fd, argv[i]);
 194:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 19f:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a2:	01 d0                	add    %edx,%eax
 1a4:	8b 00                	mov    (%eax),%eax
 1a6:	89 44 24 04          	mov    %eax,0x4(%esp)
 1aa:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ae:	89 04 24             	mov    %eax,(%esp)
 1b1:	e8 4a fe ff ff       	call   0 <wc>
    close(fd);
 1b6:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ba:	89 04 24             	mov    %eax,(%esp)
 1bd:	e8 aa 02 00 00       	call   46c <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1c2:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1c7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1cb:	3b 45 08             	cmp    0x8(%ebp),%eax
 1ce:	0f 8c 64 ff ff ff    	jl     138 <main+0x35>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1d4:	e8 6b 02 00 00       	call   444 <exit>
 1d9:	66 90                	xchg   %ax,%ax
 1db:	90                   	nop

000001dc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	57                   	push   %edi
 1e0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e4:	8b 55 10             	mov    0x10(%ebp),%edx
 1e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ea:	89 cb                	mov    %ecx,%ebx
 1ec:	89 df                	mov    %ebx,%edi
 1ee:	89 d1                	mov    %edx,%ecx
 1f0:	fc                   	cld    
 1f1:	f3 aa                	rep stos %al,%es:(%edi)
 1f3:	89 ca                	mov    %ecx,%edx
 1f5:	89 fb                	mov    %edi,%ebx
 1f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1fa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1fd:	5b                   	pop    %ebx
 1fe:	5f                   	pop    %edi
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    

00000201 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 20d:	90                   	nop
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	8d 50 01             	lea    0x1(%eax),%edx
 214:	89 55 08             	mov    %edx,0x8(%ebp)
 217:	8b 55 0c             	mov    0xc(%ebp),%edx
 21a:	8d 4a 01             	lea    0x1(%edx),%ecx
 21d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 220:	0f b6 12             	movzbl (%edx),%edx
 223:	88 10                	mov    %dl,(%eax)
 225:	0f b6 00             	movzbl (%eax),%eax
 228:	84 c0                	test   %al,%al
 22a:	75 e2                	jne    20e <strcpy+0xd>
    ;
  return os;
 22c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 22f:	c9                   	leave  
 230:	c3                   	ret    

00000231 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 231:	55                   	push   %ebp
 232:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 234:	eb 08                	jmp    23e <strcmp+0xd>
    p++, q++;
 236:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 23a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	0f b6 00             	movzbl (%eax),%eax
 244:	84 c0                	test   %al,%al
 246:	74 10                	je     258 <strcmp+0x27>
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	0f b6 10             	movzbl (%eax),%edx
 24e:	8b 45 0c             	mov    0xc(%ebp),%eax
 251:	0f b6 00             	movzbl (%eax),%eax
 254:	38 c2                	cmp    %al,%dl
 256:	74 de                	je     236 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	0f b6 00             	movzbl (%eax),%eax
 25e:	0f b6 d0             	movzbl %al,%edx
 261:	8b 45 0c             	mov    0xc(%ebp),%eax
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	0f b6 c0             	movzbl %al,%eax
 26a:	29 c2                	sub    %eax,%edx
 26c:	89 d0                	mov    %edx,%eax
}
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    

00000270 <strlen>:

uint
strlen(char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 276:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 27d:	eb 04                	jmp    283 <strlen+0x13>
 27f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 283:	8b 55 fc             	mov    -0x4(%ebp),%edx
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	01 d0                	add    %edx,%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	84 c0                	test   %al,%al
 290:	75 ed                	jne    27f <strlen+0xf>
    ;
  return n;
 292:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <memset>:

void*
memset(void *dst, int c, uint n)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 29d:	8b 45 10             	mov    0x10(%ebp),%eax
 2a0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	89 04 24             	mov    %eax,(%esp)
 2b1:	e8 26 ff ff ff       	call   1dc <stosb>
  return dst;
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b9:	c9                   	leave  
 2ba:	c3                   	ret    

000002bb <strchr>:

char*
strchr(const char *s, char c)
{
 2bb:	55                   	push   %ebp
 2bc:	89 e5                	mov    %esp,%ebp
 2be:	83 ec 04             	sub    $0x4,%esp
 2c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2c7:	eb 14                	jmp    2dd <strchr+0x22>
    if(*s == c)
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
 2cc:	0f b6 00             	movzbl (%eax),%eax
 2cf:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2d2:	75 05                	jne    2d9 <strchr+0x1e>
      return (char*)s;
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	eb 13                	jmp    2ec <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2d9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	0f b6 00             	movzbl (%eax),%eax
 2e3:	84 c0                	test   %al,%al
 2e5:	75 e2                	jne    2c9 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ec:	c9                   	leave  
 2ed:	c3                   	ret    

000002ee <gets>:

char*
gets(char *buf, int max)
{
 2ee:	55                   	push   %ebp
 2ef:	89 e5                	mov    %esp,%ebp
 2f1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2fb:	eb 4c                	jmp    349 <gets+0x5b>
    cc = read(0, &c, 1);
 2fd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 304:	00 
 305:	8d 45 ef             	lea    -0x11(%ebp),%eax
 308:	89 44 24 04          	mov    %eax,0x4(%esp)
 30c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 313:	e8 44 01 00 00       	call   45c <read>
 318:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 31b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 31f:	7f 02                	jg     323 <gets+0x35>
      break;
 321:	eb 31                	jmp    354 <gets+0x66>
    buf[i++] = c;
 323:	8b 45 f4             	mov    -0xc(%ebp),%eax
 326:	8d 50 01             	lea    0x1(%eax),%edx
 329:	89 55 f4             	mov    %edx,-0xc(%ebp)
 32c:	89 c2                	mov    %eax,%edx
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	01 c2                	add    %eax,%edx
 333:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 337:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 339:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 33d:	3c 0a                	cmp    $0xa,%al
 33f:	74 13                	je     354 <gets+0x66>
 341:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 345:	3c 0d                	cmp    $0xd,%al
 347:	74 0b                	je     354 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 349:	8b 45 f4             	mov    -0xc(%ebp),%eax
 34c:	83 c0 01             	add    $0x1,%eax
 34f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 352:	7c a9                	jl     2fd <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 354:	8b 55 f4             	mov    -0xc(%ebp),%edx
 357:	8b 45 08             	mov    0x8(%ebp),%eax
 35a:	01 d0                	add    %edx,%eax
 35c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 35f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <stat>:

int
stat(char *n, struct stat *st)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 36a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 371:	00 
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	89 04 24             	mov    %eax,(%esp)
 378:	e8 07 01 00 00       	call   484 <open>
 37d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 380:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 384:	79 07                	jns    38d <stat+0x29>
    return -1;
 386:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 38b:	eb 23                	jmp    3b0 <stat+0x4c>
  r = fstat(fd, st);
 38d:	8b 45 0c             	mov    0xc(%ebp),%eax
 390:	89 44 24 04          	mov    %eax,0x4(%esp)
 394:	8b 45 f4             	mov    -0xc(%ebp),%eax
 397:	89 04 24             	mov    %eax,(%esp)
 39a:	e8 fd 00 00 00       	call   49c <fstat>
 39f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 3a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a5:	89 04 24             	mov    %eax,(%esp)
 3a8:	e8 bf 00 00 00       	call   46c <close>
  return r;
 3ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 3b0:	c9                   	leave  
 3b1:	c3                   	ret    

000003b2 <atoi>:

int
atoi(const char *s)
{
 3b2:	55                   	push   %ebp
 3b3:	89 e5                	mov    %esp,%ebp
 3b5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3bf:	eb 25                	jmp    3e6 <atoi+0x34>
    n = n*10 + *s++ - '0';
 3c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c4:	89 d0                	mov    %edx,%eax
 3c6:	c1 e0 02             	shl    $0x2,%eax
 3c9:	01 d0                	add    %edx,%eax
 3cb:	01 c0                	add    %eax,%eax
 3cd:	89 c1                	mov    %eax,%ecx
 3cf:	8b 45 08             	mov    0x8(%ebp),%eax
 3d2:	8d 50 01             	lea    0x1(%eax),%edx
 3d5:	89 55 08             	mov    %edx,0x8(%ebp)
 3d8:	0f b6 00             	movzbl (%eax),%eax
 3db:	0f be c0             	movsbl %al,%eax
 3de:	01 c8                	add    %ecx,%eax
 3e0:	83 e8 30             	sub    $0x30,%eax
 3e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e6:	8b 45 08             	mov    0x8(%ebp),%eax
 3e9:	0f b6 00             	movzbl (%eax),%eax
 3ec:	3c 2f                	cmp    $0x2f,%al
 3ee:	7e 0a                	jle    3fa <atoi+0x48>
 3f0:	8b 45 08             	mov    0x8(%ebp),%eax
 3f3:	0f b6 00             	movzbl (%eax),%eax
 3f6:	3c 39                	cmp    $0x39,%al
 3f8:	7e c7                	jle    3c1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fd:	c9                   	leave  
 3fe:	c3                   	ret    

000003ff <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 405:	8b 45 08             	mov    0x8(%ebp),%eax
 408:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 40b:	8b 45 0c             	mov    0xc(%ebp),%eax
 40e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 411:	eb 17                	jmp    42a <memmove+0x2b>
    *dst++ = *src++;
 413:	8b 45 fc             	mov    -0x4(%ebp),%eax
 416:	8d 50 01             	lea    0x1(%eax),%edx
 419:	89 55 fc             	mov    %edx,-0x4(%ebp)
 41c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 41f:	8d 4a 01             	lea    0x1(%edx),%ecx
 422:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 425:	0f b6 12             	movzbl (%edx),%edx
 428:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 42a:	8b 45 10             	mov    0x10(%ebp),%eax
 42d:	8d 50 ff             	lea    -0x1(%eax),%edx
 430:	89 55 10             	mov    %edx,0x10(%ebp)
 433:	85 c0                	test   %eax,%eax
 435:	7f dc                	jg     413 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 437:	8b 45 08             	mov    0x8(%ebp),%eax
}
 43a:	c9                   	leave  
 43b:	c3                   	ret    

0000043c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43c:	b8 01 00 00 00       	mov    $0x1,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <exit>:
SYSCALL(exit)
 444:	b8 02 00 00 00       	mov    $0x2,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <wait>:
SYSCALL(wait)
 44c:	b8 03 00 00 00       	mov    $0x3,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <pipe>:
SYSCALL(pipe)
 454:	b8 04 00 00 00       	mov    $0x4,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <read>:
SYSCALL(read)
 45c:	b8 05 00 00 00       	mov    $0x5,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <write>:
SYSCALL(write)
 464:	b8 10 00 00 00       	mov    $0x10,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <close>:
SYSCALL(close)
 46c:	b8 15 00 00 00       	mov    $0x15,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <kill>:
SYSCALL(kill)
 474:	b8 06 00 00 00       	mov    $0x6,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <exec>:
SYSCALL(exec)
 47c:	b8 07 00 00 00       	mov    $0x7,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <open>:
SYSCALL(open)
 484:	b8 0f 00 00 00       	mov    $0xf,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <mknod>:
SYSCALL(mknod)
 48c:	b8 11 00 00 00       	mov    $0x11,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <unlink>:
SYSCALL(unlink)
 494:	b8 12 00 00 00       	mov    $0x12,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <fstat>:
SYSCALL(fstat)
 49c:	b8 08 00 00 00       	mov    $0x8,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <link>:
SYSCALL(link)
 4a4:	b8 13 00 00 00       	mov    $0x13,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <mkdir>:
SYSCALL(mkdir)
 4ac:	b8 14 00 00 00       	mov    $0x14,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <chdir>:
SYSCALL(chdir)
 4b4:	b8 09 00 00 00       	mov    $0x9,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <dup>:
SYSCALL(dup)
 4bc:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <getpid>:
SYSCALL(getpid)
 4c4:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <sbrk>:
SYSCALL(sbrk)
 4cc:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <sleep>:
SYSCALL(sleep)
 4d4:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <uptime>:
SYSCALL(uptime)
 4dc:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <date>:
SYSCALL(date)
 4e4:	b8 16 00 00 00       	mov    $0x16,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <clone>:
SYSCALL(clone)
 4ec:	b8 17 00 00 00       	mov    $0x17,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <join>:
SYSCALL(join)
 4f4:	b8 18 00 00 00       	mov    $0x18,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <threadSleep>:
SYSCALL(threadSleep)
 4fc:	b8 19 00 00 00       	mov    $0x19,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <threadWake>:
SYSCALL(threadWake)
 504:	b8 1a 00 00 00       	mov    $0x1a,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 50c:	55                   	push   %ebp
 50d:	89 e5                	mov    %esp,%ebp
 50f:	83 ec 18             	sub    $0x18,%esp
 512:	8b 45 0c             	mov    0xc(%ebp),%eax
 515:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 518:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51f:	00 
 520:	8d 45 f4             	lea    -0xc(%ebp),%eax
 523:	89 44 24 04          	mov    %eax,0x4(%esp)
 527:	8b 45 08             	mov    0x8(%ebp),%eax
 52a:	89 04 24             	mov    %eax,(%esp)
 52d:	e8 32 ff ff ff       	call   464 <write>
}
 532:	c9                   	leave  
 533:	c3                   	ret    

00000534 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 534:	55                   	push   %ebp
 535:	89 e5                	mov    %esp,%ebp
 537:	56                   	push   %esi
 538:	53                   	push   %ebx
 539:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 53c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 543:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 547:	74 17                	je     560 <printint+0x2c>
 549:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 54d:	79 11                	jns    560 <printint+0x2c>
    neg = 1;
 54f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 556:	8b 45 0c             	mov    0xc(%ebp),%eax
 559:	f7 d8                	neg    %eax
 55b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 55e:	eb 06                	jmp    566 <printint+0x32>
  } else {
    x = xx;
 560:	8b 45 0c             	mov    0xc(%ebp),%eax
 563:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 566:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 56d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 570:	8d 41 01             	lea    0x1(%ecx),%eax
 573:	89 45 f4             	mov    %eax,-0xc(%ebp)
 576:	8b 5d 10             	mov    0x10(%ebp),%ebx
 579:	8b 45 ec             	mov    -0x14(%ebp),%eax
 57c:	ba 00 00 00 00       	mov    $0x0,%edx
 581:	f7 f3                	div    %ebx
 583:	89 d0                	mov    %edx,%eax
 585:	0f b6 80 b4 10 00 00 	movzbl 0x10b4(%eax),%eax
 58c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 590:	8b 75 10             	mov    0x10(%ebp),%esi
 593:	8b 45 ec             	mov    -0x14(%ebp),%eax
 596:	ba 00 00 00 00       	mov    $0x0,%edx
 59b:	f7 f6                	div    %esi
 59d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a4:	75 c7                	jne    56d <printint+0x39>
  if(neg)
 5a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5aa:	74 10                	je     5bc <printint+0x88>
    buf[i++] = '-';
 5ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5af:	8d 50 01             	lea    0x1(%eax),%edx
 5b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5b5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5ba:	eb 1f                	jmp    5db <printint+0xa7>
 5bc:	eb 1d                	jmp    5db <printint+0xa7>
    putc(fd, buf[i]);
 5be:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c4:	01 d0                	add    %edx,%eax
 5c6:	0f b6 00             	movzbl (%eax),%eax
 5c9:	0f be c0             	movsbl %al,%eax
 5cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d0:	8b 45 08             	mov    0x8(%ebp),%eax
 5d3:	89 04 24             	mov    %eax,(%esp)
 5d6:	e8 31 ff ff ff       	call   50c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5db:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5e3:	79 d9                	jns    5be <printint+0x8a>
    putc(fd, buf[i]);
}
 5e5:	83 c4 30             	add    $0x30,%esp
 5e8:	5b                   	pop    %ebx
 5e9:	5e                   	pop    %esi
 5ea:	5d                   	pop    %ebp
 5eb:	c3                   	ret    

000005ec <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5ec:	55                   	push   %ebp
 5ed:	89 e5                	mov    %esp,%ebp
 5ef:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5f9:	8d 45 0c             	lea    0xc(%ebp),%eax
 5fc:	83 c0 04             	add    $0x4,%eax
 5ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 602:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 609:	e9 7c 01 00 00       	jmp    78a <printf+0x19e>
    c = fmt[i] & 0xff;
 60e:	8b 55 0c             	mov    0xc(%ebp),%edx
 611:	8b 45 f0             	mov    -0x10(%ebp),%eax
 614:	01 d0                	add    %edx,%eax
 616:	0f b6 00             	movzbl (%eax),%eax
 619:	0f be c0             	movsbl %al,%eax
 61c:	25 ff 00 00 00       	and    $0xff,%eax
 621:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 624:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 628:	75 2c                	jne    656 <printf+0x6a>
      if(c == '%'){
 62a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 62e:	75 0c                	jne    63c <printf+0x50>
        state = '%';
 630:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 637:	e9 4a 01 00 00       	jmp    786 <printf+0x19a>
      } else {
        putc(fd, c);
 63c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 63f:	0f be c0             	movsbl %al,%eax
 642:	89 44 24 04          	mov    %eax,0x4(%esp)
 646:	8b 45 08             	mov    0x8(%ebp),%eax
 649:	89 04 24             	mov    %eax,(%esp)
 64c:	e8 bb fe ff ff       	call   50c <putc>
 651:	e9 30 01 00 00       	jmp    786 <printf+0x19a>
      }
    } else if(state == '%'){
 656:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 65a:	0f 85 26 01 00 00    	jne    786 <printf+0x19a>
      if(c == 'd'){
 660:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 664:	75 2d                	jne    693 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 666:	8b 45 e8             	mov    -0x18(%ebp),%eax
 669:	8b 00                	mov    (%eax),%eax
 66b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 672:	00 
 673:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 67a:	00 
 67b:	89 44 24 04          	mov    %eax,0x4(%esp)
 67f:	8b 45 08             	mov    0x8(%ebp),%eax
 682:	89 04 24             	mov    %eax,(%esp)
 685:	e8 aa fe ff ff       	call   534 <printint>
        ap++;
 68a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68e:	e9 ec 00 00 00       	jmp    77f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 693:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 697:	74 06                	je     69f <printf+0xb3>
 699:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 69d:	75 2d                	jne    6cc <printf+0xe0>
        printint(fd, *ap, 16, 0);
 69f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a2:	8b 00                	mov    (%eax),%eax
 6a4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6ab:	00 
 6ac:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6b3:	00 
 6b4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b8:	8b 45 08             	mov    0x8(%ebp),%eax
 6bb:	89 04 24             	mov    %eax,(%esp)
 6be:	e8 71 fe ff ff       	call   534 <printint>
        ap++;
 6c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c7:	e9 b3 00 00 00       	jmp    77f <printf+0x193>
      } else if(c == 's'){
 6cc:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d0:	75 45                	jne    717 <printf+0x12b>
        s = (char*)*ap;
 6d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d5:	8b 00                	mov    (%eax),%eax
 6d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6da:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e2:	75 09                	jne    6ed <printf+0x101>
          s = "(null)";
 6e4:	c7 45 f4 98 0c 00 00 	movl   $0xc98,-0xc(%ebp)
        while(*s != 0){
 6eb:	eb 1e                	jmp    70b <printf+0x11f>
 6ed:	eb 1c                	jmp    70b <printf+0x11f>
          putc(fd, *s);
 6ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f2:	0f b6 00             	movzbl (%eax),%eax
 6f5:	0f be c0             	movsbl %al,%eax
 6f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 6fc:	8b 45 08             	mov    0x8(%ebp),%eax
 6ff:	89 04 24             	mov    %eax,(%esp)
 702:	e8 05 fe ff ff       	call   50c <putc>
          s++;
 707:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 70b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 70e:	0f b6 00             	movzbl (%eax),%eax
 711:	84 c0                	test   %al,%al
 713:	75 da                	jne    6ef <printf+0x103>
 715:	eb 68                	jmp    77f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 717:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 71b:	75 1d                	jne    73a <printf+0x14e>
        putc(fd, *ap);
 71d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 720:	8b 00                	mov    (%eax),%eax
 722:	0f be c0             	movsbl %al,%eax
 725:	89 44 24 04          	mov    %eax,0x4(%esp)
 729:	8b 45 08             	mov    0x8(%ebp),%eax
 72c:	89 04 24             	mov    %eax,(%esp)
 72f:	e8 d8 fd ff ff       	call   50c <putc>
        ap++;
 734:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 738:	eb 45                	jmp    77f <printf+0x193>
      } else if(c == '%'){
 73a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 73e:	75 17                	jne    757 <printf+0x16b>
        putc(fd, c);
 740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 743:	0f be c0             	movsbl %al,%eax
 746:	89 44 24 04          	mov    %eax,0x4(%esp)
 74a:	8b 45 08             	mov    0x8(%ebp),%eax
 74d:	89 04 24             	mov    %eax,(%esp)
 750:	e8 b7 fd ff ff       	call   50c <putc>
 755:	eb 28                	jmp    77f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 757:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 75e:	00 
 75f:	8b 45 08             	mov    0x8(%ebp),%eax
 762:	89 04 24             	mov    %eax,(%esp)
 765:	e8 a2 fd ff ff       	call   50c <putc>
        putc(fd, c);
 76a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 76d:	0f be c0             	movsbl %al,%eax
 770:	89 44 24 04          	mov    %eax,0x4(%esp)
 774:	8b 45 08             	mov    0x8(%ebp),%eax
 777:	89 04 24             	mov    %eax,(%esp)
 77a:	e8 8d fd ff ff       	call   50c <putc>
      }
      state = 0;
 77f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 786:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 78a:	8b 55 0c             	mov    0xc(%ebp),%edx
 78d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 790:	01 d0                	add    %edx,%eax
 792:	0f b6 00             	movzbl (%eax),%eax
 795:	84 c0                	test   %al,%al
 797:	0f 85 71 fe ff ff    	jne    60e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 79d:	c9                   	leave  
 79e:	c3                   	ret    
 79f:	90                   	nop

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a6:	8b 45 08             	mov    0x8(%ebp),%eax
 7a9:	83 e8 08             	sub    $0x8,%eax
 7ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7af:	a1 e8 10 00 00       	mov    0x10e8,%eax
 7b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7b7:	eb 24                	jmp    7dd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bc:	8b 00                	mov    (%eax),%eax
 7be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c1:	77 12                	ja     7d5 <free+0x35>
 7c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c9:	77 24                	ja     7ef <free+0x4f>
 7cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ce:	8b 00                	mov    (%eax),%eax
 7d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d3:	77 1a                	ja     7ef <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d8:	8b 00                	mov    (%eax),%eax
 7da:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e3:	76 d4                	jbe    7b9 <free+0x19>
 7e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e8:	8b 00                	mov    (%eax),%eax
 7ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ed:	76 ca                	jbe    7b9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	8b 40 04             	mov    0x4(%eax),%eax
 7f5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ff:	01 c2                	add    %eax,%edx
 801:	8b 45 fc             	mov    -0x4(%ebp),%eax
 804:	8b 00                	mov    (%eax),%eax
 806:	39 c2                	cmp    %eax,%edx
 808:	75 24                	jne    82e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 80a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80d:	8b 50 04             	mov    0x4(%eax),%edx
 810:	8b 45 fc             	mov    -0x4(%ebp),%eax
 813:	8b 00                	mov    (%eax),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	01 c2                	add    %eax,%edx
 81a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 820:	8b 45 fc             	mov    -0x4(%ebp),%eax
 823:	8b 00                	mov    (%eax),%eax
 825:	8b 10                	mov    (%eax),%edx
 827:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82a:	89 10                	mov    %edx,(%eax)
 82c:	eb 0a                	jmp    838 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 82e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 831:	8b 10                	mov    (%eax),%edx
 833:	8b 45 f8             	mov    -0x8(%ebp),%eax
 836:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 838:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83b:	8b 40 04             	mov    0x4(%eax),%eax
 83e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 845:	8b 45 fc             	mov    -0x4(%ebp),%eax
 848:	01 d0                	add    %edx,%eax
 84a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 84d:	75 20                	jne    86f <free+0xcf>
    p->s.size += bp->s.size;
 84f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 852:	8b 50 04             	mov    0x4(%eax),%edx
 855:	8b 45 f8             	mov    -0x8(%ebp),%eax
 858:	8b 40 04             	mov    0x4(%eax),%eax
 85b:	01 c2                	add    %eax,%edx
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 863:	8b 45 f8             	mov    -0x8(%ebp),%eax
 866:	8b 10                	mov    (%eax),%edx
 868:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86b:	89 10                	mov    %edx,(%eax)
 86d:	eb 08                	jmp    877 <free+0xd7>
  } else
    p->s.ptr = bp;
 86f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 872:	8b 55 f8             	mov    -0x8(%ebp),%edx
 875:	89 10                	mov    %edx,(%eax)
  freep = p;
 877:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87a:	a3 e8 10 00 00       	mov    %eax,0x10e8
}
 87f:	c9                   	leave  
 880:	c3                   	ret    

00000881 <morecore>:

static Header*
morecore(uint nu)
{
 881:	55                   	push   %ebp
 882:	89 e5                	mov    %esp,%ebp
 884:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 887:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 88e:	77 07                	ja     897 <morecore+0x16>
    nu = 4096;
 890:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 897:	8b 45 08             	mov    0x8(%ebp),%eax
 89a:	c1 e0 03             	shl    $0x3,%eax
 89d:	89 04 24             	mov    %eax,(%esp)
 8a0:	e8 27 fc ff ff       	call   4cc <sbrk>
 8a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8a8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8ac:	75 07                	jne    8b5 <morecore+0x34>
    return 0;
 8ae:	b8 00 00 00 00       	mov    $0x0,%eax
 8b3:	eb 22                	jmp    8d7 <morecore+0x56>
  hp = (Header*)p;
 8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8be:	8b 55 08             	mov    0x8(%ebp),%edx
 8c1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c7:	83 c0 08             	add    $0x8,%eax
 8ca:	89 04 24             	mov    %eax,(%esp)
 8cd:	e8 ce fe ff ff       	call   7a0 <free>
  return freep;
 8d2:	a1 e8 10 00 00       	mov    0x10e8,%eax
}
 8d7:	c9                   	leave  
 8d8:	c3                   	ret    

000008d9 <malloc>:

void*
malloc(uint nbytes)
{
 8d9:	55                   	push   %ebp
 8da:	89 e5                	mov    %esp,%ebp
 8dc:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8df:	8b 45 08             	mov    0x8(%ebp),%eax
 8e2:	83 c0 07             	add    $0x7,%eax
 8e5:	c1 e8 03             	shr    $0x3,%eax
 8e8:	83 c0 01             	add    $0x1,%eax
 8eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8ee:	a1 e8 10 00 00       	mov    0x10e8,%eax
 8f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8fa:	75 23                	jne    91f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8fc:	c7 45 f0 e0 10 00 00 	movl   $0x10e0,-0x10(%ebp)
 903:	8b 45 f0             	mov    -0x10(%ebp),%eax
 906:	a3 e8 10 00 00       	mov    %eax,0x10e8
 90b:	a1 e8 10 00 00       	mov    0x10e8,%eax
 910:	a3 e0 10 00 00       	mov    %eax,0x10e0
    base.s.size = 0;
 915:	c7 05 e4 10 00 00 00 	movl   $0x0,0x10e4
 91c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 922:	8b 00                	mov    (%eax),%eax
 924:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 927:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92a:	8b 40 04             	mov    0x4(%eax),%eax
 92d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 930:	72 4d                	jb     97f <malloc+0xa6>
      if(p->s.size == nunits)
 932:	8b 45 f4             	mov    -0xc(%ebp),%eax
 935:	8b 40 04             	mov    0x4(%eax),%eax
 938:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 93b:	75 0c                	jne    949 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 93d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 940:	8b 10                	mov    (%eax),%edx
 942:	8b 45 f0             	mov    -0x10(%ebp),%eax
 945:	89 10                	mov    %edx,(%eax)
 947:	eb 26                	jmp    96f <malloc+0x96>
      else {
        p->s.size -= nunits;
 949:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94c:	8b 40 04             	mov    0x4(%eax),%eax
 94f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 952:	89 c2                	mov    %eax,%edx
 954:	8b 45 f4             	mov    -0xc(%ebp),%eax
 957:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	8b 40 04             	mov    0x4(%eax),%eax
 960:	c1 e0 03             	shl    $0x3,%eax
 963:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 966:	8b 45 f4             	mov    -0xc(%ebp),%eax
 969:	8b 55 ec             	mov    -0x14(%ebp),%edx
 96c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 96f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 972:	a3 e8 10 00 00       	mov    %eax,0x10e8
      return (void*)(p + 1);
 977:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97a:	83 c0 08             	add    $0x8,%eax
 97d:	eb 38                	jmp    9b7 <malloc+0xde>
    }
    if(p == freep)
 97f:	a1 e8 10 00 00       	mov    0x10e8,%eax
 984:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 987:	75 1b                	jne    9a4 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 989:	8b 45 ec             	mov    -0x14(%ebp),%eax
 98c:	89 04 24             	mov    %eax,(%esp)
 98f:	e8 ed fe ff ff       	call   881 <morecore>
 994:	89 45 f4             	mov    %eax,-0xc(%ebp)
 997:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99b:	75 07                	jne    9a4 <malloc+0xcb>
        return 0;
 99d:	b8 00 00 00 00       	mov    $0x0,%eax
 9a2:	eb 13                	jmp    9b7 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ad:	8b 00                	mov    (%eax),%eax
 9af:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9b2:	e9 70 ff ff ff       	jmp    927 <malloc+0x4e>
}
 9b7:	c9                   	leave  
 9b8:	c3                   	ret    
 9b9:	66 90                	xchg   %ax,%ax
 9bb:	90                   	nop

000009bc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 9bc:	55                   	push   %ebp
 9bd:	89 e5                	mov    %esp,%ebp
 9bf:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 9c2:	8b 55 08             	mov    0x8(%ebp),%edx
 9c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 9c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 9cb:	f0 87 02             	lock xchg %eax,(%edx)
 9ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 9d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 9d4:	c9                   	leave  
 9d5:	c3                   	ret    

000009d6 <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 9d6:	55                   	push   %ebp
 9d7:	89 e5                	mov    %esp,%ebp
 9d9:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 9dc:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 9e3:	e8 f1 fe ff ff       	call   8d9 <malloc>
 9e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 9eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ee:	85 c0                	test   %eax,%eax
 9f0:	75 1b                	jne    a0d <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 9f2:	c7 44 24 04 a0 0c 00 	movl   $0xca0,0x4(%esp)
 9f9:	00 
 9fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a01:	e8 e6 fb ff ff       	call   5ec <printf>
    return -1;
 a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a0b:	eb 43                	jmp    a50 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a10:	25 ff 0f 00 00       	and    $0xfff,%eax
 a15:	85 c0                	test   %eax,%eax
 a17:	74 14                	je     a2d <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1c:	25 ff 0f 00 00       	and    $0xfff,%eax
 a21:	89 c2                	mov    %eax,%edx
 a23:	b8 00 10 00 00       	mov    $0x1000,%eax
 a28:	29 d0                	sub    %edx,%eax
 a2a:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a30:	89 44 24 08          	mov    %eax,0x8(%esp)
 a34:	8b 45 14             	mov    0x14(%ebp),%eax
 a37:	89 44 24 04          	mov    %eax,0x4(%esp)
 a3b:	8b 45 10             	mov    0x10(%ebp),%eax
 a3e:	89 04 24             	mov    %eax,(%esp)
 a41:	e8 a6 fa ff ff       	call   4ec <clone>
 a46:	8b 55 08             	mov    0x8(%ebp),%edx
 a49:	89 02                	mov    %eax,(%edx)
  return *thread;
 a4b:	8b 45 08             	mov    0x8(%ebp),%eax
 a4e:	8b 00                	mov    (%eax),%eax
}
 a50:	c9                   	leave  
 a51:	c3                   	ret    

00000a52 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 a52:	55                   	push   %ebp
 a53:	89 e5                	mov    %esp,%ebp
 a55:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 a58:	8d 45 f4             	lea    -0xc(%ebp),%eax
 a5b:	89 44 24 04          	mov    %eax,0x4(%esp)
 a5f:	8b 45 08             	mov    0x8(%ebp),%eax
 a62:	89 04 24             	mov    %eax,(%esp)
 a65:	e8 8a fa ff ff       	call   4f4 <join>
 a6a:	85 c0                	test   %eax,%eax
 a6c:	79 07                	jns    a75 <pthread_join+0x23>
    return -1;
 a6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a73:	eb 10                	jmp    a85 <pthread_join+0x33>
  }
  free(stack);
 a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a78:	89 04 24             	mov    %eax,(%esp)
 a7b:	e8 20 fd ff ff       	call   7a0 <free>
  return 0;
 a80:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a85:	c9                   	leave  
 a86:	c3                   	ret    

00000a87 <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 a87:	55                   	push   %ebp
 a88:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 a8a:	8b 45 08             	mov    0x8(%ebp),%eax
 a8d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 a93:	90                   	nop
}
 a94:	5d                   	pop    %ebp
 a95:	c3                   	ret    

00000a96 <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 a96:	55                   	push   %ebp
 a97:	89 e5                	mov    %esp,%ebp
 a99:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 a9c:	90                   	nop
 a9d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 aa4:	00 
 aa5:	8b 45 08             	mov    0x8(%ebp),%eax
 aa8:	89 04 24             	mov    %eax,(%esp)
 aab:	e8 0c ff ff ff       	call   9bc <xchg>
 ab0:	85 c0                	test   %eax,%eax
 ab2:	75 e9                	jne    a9d <pthread_mutex_lock+0x7>
  return;
 ab4:	90                   	nop
}
 ab5:	c9                   	leave  
 ab6:	c3                   	ret    

00000ab7 <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 ab7:	55                   	push   %ebp
 ab8:	89 e5                	mov    %esp,%ebp
 aba:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 abd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 ac4:	00 
 ac5:	8b 45 08             	mov    0x8(%ebp),%eax
 ac8:	89 04 24             	mov    %eax,(%esp)
 acb:	e8 ec fe ff ff       	call   9bc <xchg>
  return;
 ad0:	90                   	nop
}
 ad1:	c9                   	leave  
 ad2:	c3                   	ret    

00000ad3 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 ad3:	55                   	push   %ebp
 ad4:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 ad6:	8b 45 08             	mov    0x8(%ebp),%eax
 ad9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 adf:	8b 45 08             	mov    0x8(%ebp),%eax
 ae2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 ae9:	90                   	nop
}
 aea:	5d                   	pop    %ebp
 aeb:	c3                   	ret    

00000aec <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 aec:	55                   	push   %ebp
 aed:	89 e5                	mov    %esp,%ebp
 aef:	53                   	push   %ebx
 af0:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 af3:	8b 45 08             	mov    0x8(%ebp),%eax
 af6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 af9:	8b 45 0c             	mov    0xc(%ebp),%eax
 afc:	89 04 24             	mov    %eax,(%esp)
 aff:	e8 b3 ff ff ff       	call   ab7 <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 b04:	eb 09                	jmp    b0f <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b09:	8b 40 04             	mov    0x4(%eax),%eax
 b0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b12:	8b 40 04             	mov    0x4(%eax),%eax
 b15:	85 c0                	test   %eax,%eax
 b17:	75 ed                	jne    b06 <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 b19:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 b20:	e8 b4 fd ff ff       	call   8d9 <malloc>
 b25:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b28:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2e:	8b 58 04             	mov    0x4(%eax),%ebx
 b31:	e8 8e f9 ff ff       	call   4c4 <getpid>
 b36:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b3b:	8b 40 04             	mov    0x4(%eax),%eax
 b3e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 b45:	8b 45 0c             	mov    0xc(%ebp),%eax
 b48:	89 04 24             	mov    %eax,(%esp)
 b4b:	e8 46 ff ff ff       	call   a96 <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 b50:	8b 45 0c             	mov    0xc(%ebp),%eax
 b53:	89 04 24             	mov    %eax,(%esp)
 b56:	e8 5c ff ff ff       	call   ab7 <pthread_mutex_unlock>
  threadSleep(mutex);
 b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
 b5e:	89 04 24             	mov    %eax,(%esp)
 b61:	e8 96 f9 ff ff       	call   4fc <threadSleep>
  pthread_mutex_lock(mutex);
 b66:	8b 45 0c             	mov    0xc(%ebp),%eax
 b69:	89 04 24             	mov    %eax,(%esp)
 b6c:	e8 25 ff ff ff       	call   a96 <pthread_mutex_lock>
  return;
 b71:	90                   	nop
}
 b72:	83 c4 24             	add    $0x24,%esp
 b75:	5b                   	pop    %ebx
 b76:	5d                   	pop    %ebp
 b77:	c3                   	ret    

00000b78 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 b78:	55                   	push   %ebp
 b79:	89 e5                	mov    %esp,%ebp
 b7b:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 b7e:	8b 45 08             	mov    0x8(%ebp),%eax
 b81:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 b84:	eb 09                	jmp    b8f <pthread_cond_signal+0x17>
    mycond = mycond->next;
 b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b89:	8b 40 04             	mov    0x4(%eax),%eax
 b8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b92:	8b 00                	mov    (%eax),%eax
 b94:	83 f8 ff             	cmp    $0xffffffff,%eax
 b97:	74 ed                	je     b86 <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 b99:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b9d:	74 33                	je     bd2 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba2:	8b 00                	mov    (%eax),%eax
 ba4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 baa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 bad:	8b 45 08             	mov    0x8(%ebp),%eax
 bb0:	8b 40 04             	mov    0x4(%eax),%eax
 bb3:	8b 50 04             	mov    0x4(%eax),%edx
 bb6:	8b 45 08             	mov    0x8(%ebp),%eax
 bb9:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 bbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 bbf:	89 04 24             	mov    %eax,(%esp)
 bc2:	e8 d9 fb ff ff       	call   7a0 <free>
    threadWake(threadId);
 bc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bca:	89 04 24             	mov    %eax,(%esp)
 bcd:	e8 32 f9 ff ff       	call   504 <threadWake>
  }
  return;
 bd2:	90                   	nop
}
 bd3:	c9                   	leave  
 bd4:	c3                   	ret    

00000bd5 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 bd5:	55                   	push   %ebp
 bd6:	89 e5                	mov    %esp,%ebp
 bd8:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 bdb:	8b 45 08             	mov    0x8(%ebp),%eax
 bde:	8b 55 10             	mov    0x10(%ebp),%edx
 be1:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 be3:	8b 45 08             	mov    0x8(%ebp),%eax
 be6:	83 c0 04             	add    $0x4,%eax
 be9:	89 04 24             	mov    %eax,(%esp)
 bec:	e8 e2 fe ff ff       	call   ad3 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 bf1:	8b 45 08             	mov    0x8(%ebp),%eax
 bf4:	83 c0 0c             	add    $0xc,%eax
 bf7:	89 04 24             	mov    %eax,(%esp)
 bfa:	e8 88 fe ff ff       	call   a87 <pthread_mutex_init>
  return;
 bff:	90                   	nop
}
 c00:	c9                   	leave  
 c01:	c3                   	ret    

00000c02 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 c02:	55                   	push   %ebp
 c03:	89 e5                	mov    %esp,%ebp
 c05:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 c08:	8b 45 08             	mov    0x8(%ebp),%eax
 c0b:	8b 00                	mov    (%eax),%eax
 c0d:	8d 50 ff             	lea    -0x1(%eax),%edx
 c10:	8b 45 08             	mov    0x8(%ebp),%eax
 c13:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 c15:	8b 45 08             	mov    0x8(%ebp),%eax
 c18:	8b 00                	mov    (%eax),%eax
 c1a:	85 c0                	test   %eax,%eax
 c1c:	79 18                	jns    c36 <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 c1e:	8b 45 08             	mov    0x8(%ebp),%eax
 c21:	8d 50 0c             	lea    0xc(%eax),%edx
 c24:	8b 45 08             	mov    0x8(%ebp),%eax
 c27:	83 c0 04             	add    $0x4,%eax
 c2a:	89 54 24 04          	mov    %edx,0x4(%esp)
 c2e:	89 04 24             	mov    %eax,(%esp)
 c31:	e8 b6 fe ff ff       	call   aec <pthread_cond_wait>
  }
  return;
 c36:	90                   	nop
}
 c37:	c9                   	leave  
 c38:	c3                   	ret    

00000c39 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 c39:	55                   	push   %ebp
 c3a:	89 e5                	mov    %esp,%ebp
 c3c:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 c3f:	8b 45 08             	mov    0x8(%ebp),%eax
 c42:	8b 00                	mov    (%eax),%eax
 c44:	8d 50 01             	lea    0x1(%eax),%edx
 c47:	8b 45 08             	mov    0x8(%ebp),%eax
 c4a:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 c4c:	8b 45 08             	mov    0x8(%ebp),%eax
 c4f:	83 c0 04             	add    $0x4,%eax
 c52:	89 04 24             	mov    %eax,(%esp)
 c55:	e8 1e ff ff ff       	call   b78 <pthread_cond_signal>
  return;
 c5a:	90                   	nop
}
 c5b:	c9                   	leave  
 c5c:	c3                   	ret    
