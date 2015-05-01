
_prod-cons:     file format elf32-i386


Disassembly of section .text:

00000000 <put>:

mpthread_mutex_t mutex;
mpthread_cond_t empty;
mpthread_cond_t full;

void put(int value){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
  buffer[right] = value;
   3:	a1 a8 11 00 00       	mov    0x11a8,%eax
   8:	8b 55 08             	mov    0x8(%ebp),%edx
   b:	89 14 85 c0 11 00 00 	mov    %edx,0x11c0(,%eax,4)
  right = (right +1) % SIZE;
  12:	a1 a8 11 00 00       	mov    0x11a8,%eax
  17:	8d 48 01             	lea    0x1(%eax),%ecx
  1a:	ba 67 66 66 66       	mov    $0x66666667,%edx
  1f:	89 c8                	mov    %ecx,%eax
  21:	f7 ea                	imul   %edx
  23:	c1 fa 02             	sar    $0x2,%edx
  26:	89 c8                	mov    %ecx,%eax
  28:	c1 f8 1f             	sar    $0x1f,%eax
  2b:	29 c2                	sub    %eax,%edx
  2d:	89 d0                	mov    %edx,%eax
  2f:	c1 e0 02             	shl    $0x2,%eax
  32:	01 d0                	add    %edx,%eax
  34:	01 c0                	add    %eax,%eax
  36:	29 c1                	sub    %eax,%ecx
  38:	89 ca                	mov    %ecx,%edx
  3a:	89 15 a8 11 00 00    	mov    %edx,0x11a8
  count ++;
  40:	a1 e8 11 00 00       	mov    0x11e8,%eax
  45:	83 c0 01             	add    $0x1,%eax
  48:	a3 e8 11 00 00       	mov    %eax,0x11e8
}
  4d:	5d                   	pop    %ebp
  4e:	c3                   	ret    

0000004f <get>:

int get(){
  4f:	55                   	push   %ebp
  50:	89 e5                	mov    %esp,%ebp
  52:	83 ec 10             	sub    $0x10,%esp
  int value = buffer[left];
  55:	a1 ac 11 00 00       	mov    0x11ac,%eax
  5a:	8b 04 85 c0 11 00 00 	mov    0x11c0(,%eax,4),%eax
  61:	89 45 fc             	mov    %eax,-0x4(%ebp)
  left = (left + 1) % SIZE;
  64:	a1 ac 11 00 00       	mov    0x11ac,%eax
  69:	8d 48 01             	lea    0x1(%eax),%ecx
  6c:	ba 67 66 66 66       	mov    $0x66666667,%edx
  71:	89 c8                	mov    %ecx,%eax
  73:	f7 ea                	imul   %edx
  75:	c1 fa 02             	sar    $0x2,%edx
  78:	89 c8                	mov    %ecx,%eax
  7a:	c1 f8 1f             	sar    $0x1f,%eax
  7d:	29 c2                	sub    %eax,%edx
  7f:	89 d0                	mov    %edx,%eax
  81:	c1 e0 02             	shl    $0x2,%eax
  84:	01 d0                	add    %edx,%eax
  86:	01 c0                	add    %eax,%eax
  88:	29 c1                	sub    %eax,%ecx
  8a:	89 ca                	mov    %ecx,%edx
  8c:	89 15 ac 11 00 00    	mov    %edx,0x11ac
  count --;
  92:	a1 e8 11 00 00       	mov    0x11e8,%eax
  97:	83 e8 01             	sub    $0x1,%eax
  9a:	a3 e8 11 00 00       	mov    %eax,0x11e8
  return value;
  9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
} 
  a2:	c9                   	leave  
  a3:	c3                   	ret    

000000a4 <producer>:

void producer(void *arg)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	83 ec 28             	sub    $0x28,%esp
  int i; 
  for(i = 0; i< NITER; i++)
  aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  b1:	eb 53                	jmp    106 <producer+0x62>
  {
    pthread_mutex_lock(&mutex);
  b3:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
  ba:	e8 4f 0a 00 00       	call   b0e <pthread_mutex_lock>
    while(count == SIZE)
  bf:	eb 14                	jmp    d5 <producer+0x31>
      pthread_cond_wait(&full, &mutex);
  c1:	c7 44 24 04 b0 11 00 	movl   $0x11b0,0x4(%esp)
  c8:	00 
  c9:	c7 04 24 a0 11 00 00 	movl   $0x11a0,(%esp)
  d0:	e8 8f 0a 00 00       	call   b64 <pthread_cond_wait>
{
  int i; 
  for(i = 0; i< NITER; i++)
  {
    pthread_mutex_lock(&mutex);
    while(count == SIZE)
  d5:	a1 e8 11 00 00       	mov    0x11e8,%eax
  da:	83 f8 0a             	cmp    $0xa,%eax
  dd:	74 e2                	je     c1 <producer+0x1d>
      pthread_cond_wait(&full, &mutex);
    put(i);
  df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  e2:	89 04 24             	mov    %eax,(%esp)
  e5:	e8 16 ff ff ff       	call   0 <put>
    pthread_cond_signal(&empty);
  ea:	c7 04 24 ec 11 00 00 	movl   $0x11ec,(%esp)
  f1:	e8 fa 0a 00 00       	call   bf0 <pthread_cond_signal>
    pthread_mutex_unlock(&mutex);
  f6:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
  fd:	e8 2d 0a 00 00       	call   b2f <pthread_mutex_unlock>
} 

void producer(void *arg)
{
  int i; 
  for(i = 0; i< NITER; i++)
 102:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 106:	83 7d f4 31          	cmpl   $0x31,-0xc(%ebp)
 10a:	7e a7                	jle    b3 <producer+0xf>
      pthread_cond_wait(&full, &mutex);
    put(i);
    pthread_cond_signal(&empty);
    pthread_mutex_unlock(&mutex);
  }
  exit();
 10c:	e8 ab 03 00 00       	call   4bc <exit>

00000111 <consumer>:
}

void consumer(void *arg){
 111:	55                   	push   %ebp
 112:	89 e5                	mov    %esp,%ebp
 114:	83 ec 28             	sub    $0x28,%esp
  int i;
  for(i=0; i < NITER; i++){
 117:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 11e:	eb 70                	jmp    190 <consumer+0x7f>
    pthread_mutex_lock(&mutex);
 120:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
 127:	e8 e2 09 00 00       	call   b0e <pthread_mutex_lock>
    while(count == 0)
 12c:	eb 14                	jmp    142 <consumer+0x31>
      pthread_cond_wait(&full, &mutex);
 12e:	c7 44 24 04 b0 11 00 	movl   $0x11b0,0x4(%esp)
 135:	00 
 136:	c7 04 24 a0 11 00 00 	movl   $0x11a0,(%esp)
 13d:	e8 22 0a 00 00       	call   b64 <pthread_cond_wait>

void consumer(void *arg){
  int i;
  for(i=0; i < NITER; i++){
    pthread_mutex_lock(&mutex);
    while(count == 0)
 142:	a1 e8 11 00 00       	mov    0x11e8,%eax
 147:	85 c0                	test   %eax,%eax
 149:	74 e3                	je     12e <consumer+0x1d>
      pthread_cond_wait(&full, &mutex);
    int value = get(i);
 14b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 14e:	89 04 24             	mov    %eax,(%esp)
 151:	e8 f9 fe ff ff       	call   4f <get>
 156:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pthread_cond_signal(&full);
 159:	c7 04 24 a0 11 00 00 	movl   $0x11a0,(%esp)
 160:	e8 8b 0a 00 00       	call   bf0 <pthread_cond_signal>
    pthread_mutex_unlock(&mutex);
 165:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
 16c:	e8 be 09 00 00       	call   b2f <pthread_mutex_unlock>
    printf(1, "%d\n", value);
 171:	8b 45 f0             	mov    -0x10(%ebp),%eax
 174:	89 44 24 08          	mov    %eax,0x8(%esp)
 178:	c7 44 24 04 d8 0c 00 	movl   $0xcd8,0x4(%esp)
 17f:	00 
 180:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 187:	e8 d8 04 00 00       	call   664 <printf>
  exit();
}

void consumer(void *arg){
  int i;
  for(i=0; i < NITER; i++){
 18c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 190:	83 7d f4 31          	cmpl   $0x31,-0xc(%ebp)
 194:	7e 8a                	jle    120 <consumer+0xf>
    int value = get(i);
    pthread_cond_signal(&full);
    pthread_mutex_unlock(&mutex);
    printf(1, "%d\n", value);
  }
  exit();
 196:	e8 21 03 00 00       	call   4bc <exit>

0000019b <main>:
}

int main(){
 19b:	55                   	push   %ebp
 19c:	89 e5                	mov    %esp,%ebp
 19e:	83 e4 f0             	and    $0xfffffff0,%esp
 1a1:	83 ec 20             	sub    $0x20,%esp
  printf(1, "Parent starts\n");
 1a4:	c7 44 24 04 dc 0c 00 	movl   $0xcdc,0x4(%esp)
 1ab:	00 
 1ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b3:	e8 ac 04 00 00       	call   664 <printf>
  
  mpthread_t p1, p2;
  pthread_mutex_init(&mutex);
 1b8:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
 1bf:	e8 3b 09 00 00       	call   aff <pthread_mutex_init>
  pthread_cond_init(&empty);
 1c4:	c7 04 24 ec 11 00 00 	movl   $0x11ec,(%esp)
 1cb:	e8 7b 09 00 00       	call   b4b <pthread_cond_init>
  pthread_cond_init(&full);
 1d0:	c7 04 24 a0 11 00 00 	movl   $0x11a0,(%esp)
 1d7:	e8 6f 09 00 00       	call   b4b <pthread_cond_init>
  
  pthread_create(&p1, NULL, producer, NULL);
 1dc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 1e3:	00 
 1e4:	c7 44 24 08 a4 00 00 	movl   $0xa4,0x8(%esp)
 1eb:	00 
 1ec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f3:	00 
 1f4:	8d 44 24 1c          	lea    0x1c(%esp),%eax
 1f8:	89 04 24             	mov    %eax,(%esp)
 1fb:	e8 4e 08 00 00       	call   a4e <pthread_create>
  pthread_create(&p2, NULL, consumer, NULL);
 200:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 207:	00 
 208:	c7 44 24 08 11 01 00 	movl   $0x111,0x8(%esp)
 20f:	00 
 210:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 217:	00 
 218:	8d 44 24 18          	lea    0x18(%esp),%eax
 21c:	89 04 24             	mov    %eax,(%esp)
 21f:	e8 2a 08 00 00       	call   a4e <pthread_create>

  pthread_join(p1, NULL);
 224:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 228:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 22f:	00 
 230:	89 04 24             	mov    %eax,(%esp)
 233:	e8 92 08 00 00       	call   aca <pthread_join>
  pthread_join(p2, NULL);
 238:	8b 44 24 18          	mov    0x18(%esp),%eax
 23c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 243:	00 
 244:	89 04 24             	mov    %eax,(%esp)
 247:	e8 7e 08 00 00       	call   aca <pthread_join>

  exit();
 24c:	e8 6b 02 00 00       	call   4bc <exit>
 251:	66 90                	xchg   %ax,%ax
 253:	90                   	nop

00000254 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	57                   	push   %edi
 258:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 259:	8b 4d 08             	mov    0x8(%ebp),%ecx
 25c:	8b 55 10             	mov    0x10(%ebp),%edx
 25f:	8b 45 0c             	mov    0xc(%ebp),%eax
 262:	89 cb                	mov    %ecx,%ebx
 264:	89 df                	mov    %ebx,%edi
 266:	89 d1                	mov    %edx,%ecx
 268:	fc                   	cld    
 269:	f3 aa                	rep stos %al,%es:(%edi)
 26b:	89 ca                	mov    %ecx,%edx
 26d:	89 fb                	mov    %edi,%ebx
 26f:	89 5d 08             	mov    %ebx,0x8(%ebp)
 272:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 275:	5b                   	pop    %ebx
 276:	5f                   	pop    %edi
 277:	5d                   	pop    %ebp
 278:	c3                   	ret    

00000279 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
 27c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
 282:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 285:	90                   	nop
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	8d 50 01             	lea    0x1(%eax),%edx
 28c:	89 55 08             	mov    %edx,0x8(%ebp)
 28f:	8b 55 0c             	mov    0xc(%ebp),%edx
 292:	8d 4a 01             	lea    0x1(%edx),%ecx
 295:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 298:	0f b6 12             	movzbl (%edx),%edx
 29b:	88 10                	mov    %dl,(%eax)
 29d:	0f b6 00             	movzbl (%eax),%eax
 2a0:	84 c0                	test   %al,%al
 2a2:	75 e2                	jne    286 <strcpy+0xd>
    ;
  return os;
 2a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a7:	c9                   	leave  
 2a8:	c3                   	ret    

000002a9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a9:	55                   	push   %ebp
 2aa:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 2ac:	eb 08                	jmp    2b6 <strcmp+0xd>
    p++, q++;
 2ae:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	0f b6 00             	movzbl (%eax),%eax
 2bc:	84 c0                	test   %al,%al
 2be:	74 10                	je     2d0 <strcmp+0x27>
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
 2c3:	0f b6 10             	movzbl (%eax),%edx
 2c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c9:	0f b6 00             	movzbl (%eax),%eax
 2cc:	38 c2                	cmp    %al,%dl
 2ce:	74 de                	je     2ae <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	0f b6 00             	movzbl (%eax),%eax
 2d6:	0f b6 d0             	movzbl %al,%edx
 2d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dc:	0f b6 00             	movzbl (%eax),%eax
 2df:	0f b6 c0             	movzbl %al,%eax
 2e2:	29 c2                	sub    %eax,%edx
 2e4:	89 d0                	mov    %edx,%eax
}
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    

000002e8 <strlen>:

uint
strlen(char *s)
{
 2e8:	55                   	push   %ebp
 2e9:	89 e5                	mov    %esp,%ebp
 2eb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 2ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2f5:	eb 04                	jmp    2fb <strlen+0x13>
 2f7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2fe:	8b 45 08             	mov    0x8(%ebp),%eax
 301:	01 d0                	add    %edx,%eax
 303:	0f b6 00             	movzbl (%eax),%eax
 306:	84 c0                	test   %al,%al
 308:	75 ed                	jne    2f7 <strlen+0xf>
    ;
  return n;
 30a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 30d:	c9                   	leave  
 30e:	c3                   	ret    

0000030f <memset>:

void*
memset(void *dst, int c, uint n)
{
 30f:	55                   	push   %ebp
 310:	89 e5                	mov    %esp,%ebp
 312:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 315:	8b 45 10             	mov    0x10(%ebp),%eax
 318:	89 44 24 08          	mov    %eax,0x8(%esp)
 31c:	8b 45 0c             	mov    0xc(%ebp),%eax
 31f:	89 44 24 04          	mov    %eax,0x4(%esp)
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	89 04 24             	mov    %eax,(%esp)
 329:	e8 26 ff ff ff       	call   254 <stosb>
  return dst;
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <strchr>:

char*
strchr(const char *s, char c)
{
 333:	55                   	push   %ebp
 334:	89 e5                	mov    %esp,%ebp
 336:	83 ec 04             	sub    $0x4,%esp
 339:	8b 45 0c             	mov    0xc(%ebp),%eax
 33c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 33f:	eb 14                	jmp    355 <strchr+0x22>
    if(*s == c)
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	0f b6 00             	movzbl (%eax),%eax
 347:	3a 45 fc             	cmp    -0x4(%ebp),%al
 34a:	75 05                	jne    351 <strchr+0x1e>
      return (char*)s;
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	eb 13                	jmp    364 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 351:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 355:	8b 45 08             	mov    0x8(%ebp),%eax
 358:	0f b6 00             	movzbl (%eax),%eax
 35b:	84 c0                	test   %al,%al
 35d:	75 e2                	jne    341 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 35f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 364:	c9                   	leave  
 365:	c3                   	ret    

00000366 <gets>:

char*
gets(char *buf, int max)
{
 366:	55                   	push   %ebp
 367:	89 e5                	mov    %esp,%ebp
 369:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 36c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 373:	eb 4c                	jmp    3c1 <gets+0x5b>
    cc = read(0, &c, 1);
 375:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 37c:	00 
 37d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 380:	89 44 24 04          	mov    %eax,0x4(%esp)
 384:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 38b:	e8 44 01 00 00       	call   4d4 <read>
 390:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 393:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 397:	7f 02                	jg     39b <gets+0x35>
      break;
 399:	eb 31                	jmp    3cc <gets+0x66>
    buf[i++] = c;
 39b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 39e:	8d 50 01             	lea    0x1(%eax),%edx
 3a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3a4:	89 c2                	mov    %eax,%edx
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
 3a9:	01 c2                	add    %eax,%edx
 3ab:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3af:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 3b1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3b5:	3c 0a                	cmp    $0xa,%al
 3b7:	74 13                	je     3cc <gets+0x66>
 3b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3bd:	3c 0d                	cmp    $0xd,%al
 3bf:	74 0b                	je     3cc <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3c4:	83 c0 01             	add    $0x1,%eax
 3c7:	3b 45 0c             	cmp    0xc(%ebp),%eax
 3ca:	7c a9                	jl     375 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3cf:	8b 45 08             	mov    0x8(%ebp),%eax
 3d2:	01 d0                	add    %edx,%eax
 3d4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 3d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3da:	c9                   	leave  
 3db:	c3                   	ret    

000003dc <stat>:

int
stat(char *n, struct stat *st)
{
 3dc:	55                   	push   %ebp
 3dd:	89 e5                	mov    %esp,%ebp
 3df:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3e9:	00 
 3ea:	8b 45 08             	mov    0x8(%ebp),%eax
 3ed:	89 04 24             	mov    %eax,(%esp)
 3f0:	e8 07 01 00 00       	call   4fc <open>
 3f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 3f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3fc:	79 07                	jns    405 <stat+0x29>
    return -1;
 3fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 403:	eb 23                	jmp    428 <stat+0x4c>
  r = fstat(fd, st);
 405:	8b 45 0c             	mov    0xc(%ebp),%eax
 408:	89 44 24 04          	mov    %eax,0x4(%esp)
 40c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40f:	89 04 24             	mov    %eax,(%esp)
 412:	e8 fd 00 00 00       	call   514 <fstat>
 417:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 41a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41d:	89 04 24             	mov    %eax,(%esp)
 420:	e8 bf 00 00 00       	call   4e4 <close>
  return r;
 425:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 428:	c9                   	leave  
 429:	c3                   	ret    

0000042a <atoi>:

int
atoi(const char *s)
{
 42a:	55                   	push   %ebp
 42b:	89 e5                	mov    %esp,%ebp
 42d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 430:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 437:	eb 25                	jmp    45e <atoi+0x34>
    n = n*10 + *s++ - '0';
 439:	8b 55 fc             	mov    -0x4(%ebp),%edx
 43c:	89 d0                	mov    %edx,%eax
 43e:	c1 e0 02             	shl    $0x2,%eax
 441:	01 d0                	add    %edx,%eax
 443:	01 c0                	add    %eax,%eax
 445:	89 c1                	mov    %eax,%ecx
 447:	8b 45 08             	mov    0x8(%ebp),%eax
 44a:	8d 50 01             	lea    0x1(%eax),%edx
 44d:	89 55 08             	mov    %edx,0x8(%ebp)
 450:	0f b6 00             	movzbl (%eax),%eax
 453:	0f be c0             	movsbl %al,%eax
 456:	01 c8                	add    %ecx,%eax
 458:	83 e8 30             	sub    $0x30,%eax
 45b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 45e:	8b 45 08             	mov    0x8(%ebp),%eax
 461:	0f b6 00             	movzbl (%eax),%eax
 464:	3c 2f                	cmp    $0x2f,%al
 466:	7e 0a                	jle    472 <atoi+0x48>
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	0f b6 00             	movzbl (%eax),%eax
 46e:	3c 39                	cmp    $0x39,%al
 470:	7e c7                	jle    439 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 472:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 475:	c9                   	leave  
 476:	c3                   	ret    

00000477 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 477:	55                   	push   %ebp
 478:	89 e5                	mov    %esp,%ebp
 47a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 47d:	8b 45 08             	mov    0x8(%ebp),%eax
 480:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 483:	8b 45 0c             	mov    0xc(%ebp),%eax
 486:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 489:	eb 17                	jmp    4a2 <memmove+0x2b>
    *dst++ = *src++;
 48b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 48e:	8d 50 01             	lea    0x1(%eax),%edx
 491:	89 55 fc             	mov    %edx,-0x4(%ebp)
 494:	8b 55 f8             	mov    -0x8(%ebp),%edx
 497:	8d 4a 01             	lea    0x1(%edx),%ecx
 49a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 49d:	0f b6 12             	movzbl (%edx),%edx
 4a0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4a2:	8b 45 10             	mov    0x10(%ebp),%eax
 4a5:	8d 50 ff             	lea    -0x1(%eax),%edx
 4a8:	89 55 10             	mov    %edx,0x10(%ebp)
 4ab:	85 c0                	test   %eax,%eax
 4ad:	7f dc                	jg     48b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 4af:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4b2:	c9                   	leave  
 4b3:	c3                   	ret    

000004b4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4b4:	b8 01 00 00 00       	mov    $0x1,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <exit>:
SYSCALL(exit)
 4bc:	b8 02 00 00 00       	mov    $0x2,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <wait>:
SYSCALL(wait)
 4c4:	b8 03 00 00 00       	mov    $0x3,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <pipe>:
SYSCALL(pipe)
 4cc:	b8 04 00 00 00       	mov    $0x4,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <read>:
SYSCALL(read)
 4d4:	b8 05 00 00 00       	mov    $0x5,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <write>:
SYSCALL(write)
 4dc:	b8 10 00 00 00       	mov    $0x10,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <close>:
SYSCALL(close)
 4e4:	b8 15 00 00 00       	mov    $0x15,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <kill>:
SYSCALL(kill)
 4ec:	b8 06 00 00 00       	mov    $0x6,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <exec>:
SYSCALL(exec)
 4f4:	b8 07 00 00 00       	mov    $0x7,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <open>:
SYSCALL(open)
 4fc:	b8 0f 00 00 00       	mov    $0xf,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <mknod>:
SYSCALL(mknod)
 504:	b8 11 00 00 00       	mov    $0x11,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <unlink>:
SYSCALL(unlink)
 50c:	b8 12 00 00 00       	mov    $0x12,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <fstat>:
SYSCALL(fstat)
 514:	b8 08 00 00 00       	mov    $0x8,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <link>:
SYSCALL(link)
 51c:	b8 13 00 00 00       	mov    $0x13,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <mkdir>:
SYSCALL(mkdir)
 524:	b8 14 00 00 00       	mov    $0x14,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <chdir>:
SYSCALL(chdir)
 52c:	b8 09 00 00 00       	mov    $0x9,%eax
 531:	cd 40                	int    $0x40
 533:	c3                   	ret    

00000534 <dup>:
SYSCALL(dup)
 534:	b8 0a 00 00 00       	mov    $0xa,%eax
 539:	cd 40                	int    $0x40
 53b:	c3                   	ret    

0000053c <getpid>:
SYSCALL(getpid)
 53c:	b8 0b 00 00 00       	mov    $0xb,%eax
 541:	cd 40                	int    $0x40
 543:	c3                   	ret    

00000544 <sbrk>:
SYSCALL(sbrk)
 544:	b8 0c 00 00 00       	mov    $0xc,%eax
 549:	cd 40                	int    $0x40
 54b:	c3                   	ret    

0000054c <sleep>:
SYSCALL(sleep)
 54c:	b8 0d 00 00 00       	mov    $0xd,%eax
 551:	cd 40                	int    $0x40
 553:	c3                   	ret    

00000554 <uptime>:
SYSCALL(uptime)
 554:	b8 0e 00 00 00       	mov    $0xe,%eax
 559:	cd 40                	int    $0x40
 55b:	c3                   	ret    

0000055c <date>:
SYSCALL(date)
 55c:	b8 16 00 00 00       	mov    $0x16,%eax
 561:	cd 40                	int    $0x40
 563:	c3                   	ret    

00000564 <clone>:
SYSCALL(clone)
 564:	b8 17 00 00 00       	mov    $0x17,%eax
 569:	cd 40                	int    $0x40
 56b:	c3                   	ret    

0000056c <join>:
SYSCALL(join)
 56c:	b8 18 00 00 00       	mov    $0x18,%eax
 571:	cd 40                	int    $0x40
 573:	c3                   	ret    

00000574 <threadSleep>:
SYSCALL(threadSleep)
 574:	b8 19 00 00 00       	mov    $0x19,%eax
 579:	cd 40                	int    $0x40
 57b:	c3                   	ret    

0000057c <threadWake>:
SYSCALL(threadWake)
 57c:	b8 1a 00 00 00       	mov    $0x1a,%eax
 581:	cd 40                	int    $0x40
 583:	c3                   	ret    

00000584 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	83 ec 18             	sub    $0x18,%esp
 58a:	8b 45 0c             	mov    0xc(%ebp),%eax
 58d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 590:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 597:	00 
 598:	8d 45 f4             	lea    -0xc(%ebp),%eax
 59b:	89 44 24 04          	mov    %eax,0x4(%esp)
 59f:	8b 45 08             	mov    0x8(%ebp),%eax
 5a2:	89 04 24             	mov    %eax,(%esp)
 5a5:	e8 32 ff ff ff       	call   4dc <write>
}
 5aa:	c9                   	leave  
 5ab:	c3                   	ret    

000005ac <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	56                   	push   %esi
 5b0:	53                   	push   %ebx
 5b1:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5bb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5bf:	74 17                	je     5d8 <printint+0x2c>
 5c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5c5:	79 11                	jns    5d8 <printint+0x2c>
    neg = 1;
 5c7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 5d1:	f7 d8                	neg    %eax
 5d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5d6:	eb 06                	jmp    5de <printint+0x32>
  } else {
    x = xx;
 5d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 5db:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5e5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 5e8:	8d 41 01             	lea    0x1(%ecx),%eax
 5eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5ee:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5f4:	ba 00 00 00 00       	mov    $0x0,%edx
 5f9:	f7 f3                	div    %ebx
 5fb:	89 d0                	mov    %edx,%eax
 5fd:	0f b6 80 60 11 00 00 	movzbl 0x1160(%eax),%eax
 604:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 608:	8b 75 10             	mov    0x10(%ebp),%esi
 60b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 60e:	ba 00 00 00 00       	mov    $0x0,%edx
 613:	f7 f6                	div    %esi
 615:	89 45 ec             	mov    %eax,-0x14(%ebp)
 618:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 61c:	75 c7                	jne    5e5 <printint+0x39>
  if(neg)
 61e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 622:	74 10                	je     634 <printint+0x88>
    buf[i++] = '-';
 624:	8b 45 f4             	mov    -0xc(%ebp),%eax
 627:	8d 50 01             	lea    0x1(%eax),%edx
 62a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 62d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 632:	eb 1f                	jmp    653 <printint+0xa7>
 634:	eb 1d                	jmp    653 <printint+0xa7>
    putc(fd, buf[i]);
 636:	8d 55 dc             	lea    -0x24(%ebp),%edx
 639:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63c:	01 d0                	add    %edx,%eax
 63e:	0f b6 00             	movzbl (%eax),%eax
 641:	0f be c0             	movsbl %al,%eax
 644:	89 44 24 04          	mov    %eax,0x4(%esp)
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	89 04 24             	mov    %eax,(%esp)
 64e:	e8 31 ff ff ff       	call   584 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 653:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 657:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 65b:	79 d9                	jns    636 <printint+0x8a>
    putc(fd, buf[i]);
}
 65d:	83 c4 30             	add    $0x30,%esp
 660:	5b                   	pop    %ebx
 661:	5e                   	pop    %esi
 662:	5d                   	pop    %ebp
 663:	c3                   	ret    

00000664 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 664:	55                   	push   %ebp
 665:	89 e5                	mov    %esp,%ebp
 667:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 66a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 671:	8d 45 0c             	lea    0xc(%ebp),%eax
 674:	83 c0 04             	add    $0x4,%eax
 677:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 67a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 681:	e9 7c 01 00 00       	jmp    802 <printf+0x19e>
    c = fmt[i] & 0xff;
 686:	8b 55 0c             	mov    0xc(%ebp),%edx
 689:	8b 45 f0             	mov    -0x10(%ebp),%eax
 68c:	01 d0                	add    %edx,%eax
 68e:	0f b6 00             	movzbl (%eax),%eax
 691:	0f be c0             	movsbl %al,%eax
 694:	25 ff 00 00 00       	and    $0xff,%eax
 699:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 69c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6a0:	75 2c                	jne    6ce <printf+0x6a>
      if(c == '%'){
 6a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6a6:	75 0c                	jne    6b4 <printf+0x50>
        state = '%';
 6a8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6af:	e9 4a 01 00 00       	jmp    7fe <printf+0x19a>
      } else {
        putc(fd, c);
 6b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b7:	0f be c0             	movsbl %al,%eax
 6ba:	89 44 24 04          	mov    %eax,0x4(%esp)
 6be:	8b 45 08             	mov    0x8(%ebp),%eax
 6c1:	89 04 24             	mov    %eax,(%esp)
 6c4:	e8 bb fe ff ff       	call   584 <putc>
 6c9:	e9 30 01 00 00       	jmp    7fe <printf+0x19a>
      }
    } else if(state == '%'){
 6ce:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6d2:	0f 85 26 01 00 00    	jne    7fe <printf+0x19a>
      if(c == 'd'){
 6d8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6dc:	75 2d                	jne    70b <printf+0xa7>
        printint(fd, *ap, 10, 1);
 6de:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e1:	8b 00                	mov    (%eax),%eax
 6e3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 6ea:	00 
 6eb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 6f2:	00 
 6f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f7:	8b 45 08             	mov    0x8(%ebp),%eax
 6fa:	89 04 24             	mov    %eax,(%esp)
 6fd:	e8 aa fe ff ff       	call   5ac <printint>
        ap++;
 702:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 706:	e9 ec 00 00 00       	jmp    7f7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 70b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 70f:	74 06                	je     717 <printf+0xb3>
 711:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 715:	75 2d                	jne    744 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 717:	8b 45 e8             	mov    -0x18(%ebp),%eax
 71a:	8b 00                	mov    (%eax),%eax
 71c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 723:	00 
 724:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 72b:	00 
 72c:	89 44 24 04          	mov    %eax,0x4(%esp)
 730:	8b 45 08             	mov    0x8(%ebp),%eax
 733:	89 04 24             	mov    %eax,(%esp)
 736:	e8 71 fe ff ff       	call   5ac <printint>
        ap++;
 73b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73f:	e9 b3 00 00 00       	jmp    7f7 <printf+0x193>
      } else if(c == 's'){
 744:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 748:	75 45                	jne    78f <printf+0x12b>
        s = (char*)*ap;
 74a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 74d:	8b 00                	mov    (%eax),%eax
 74f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 752:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 756:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 75a:	75 09                	jne    765 <printf+0x101>
          s = "(null)";
 75c:	c7 45 f4 eb 0c 00 00 	movl   $0xceb,-0xc(%ebp)
        while(*s != 0){
 763:	eb 1e                	jmp    783 <printf+0x11f>
 765:	eb 1c                	jmp    783 <printf+0x11f>
          putc(fd, *s);
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	0f b6 00             	movzbl (%eax),%eax
 76d:	0f be c0             	movsbl %al,%eax
 770:	89 44 24 04          	mov    %eax,0x4(%esp)
 774:	8b 45 08             	mov    0x8(%ebp),%eax
 777:	89 04 24             	mov    %eax,(%esp)
 77a:	e8 05 fe ff ff       	call   584 <putc>
          s++;
 77f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 783:	8b 45 f4             	mov    -0xc(%ebp),%eax
 786:	0f b6 00             	movzbl (%eax),%eax
 789:	84 c0                	test   %al,%al
 78b:	75 da                	jne    767 <printf+0x103>
 78d:	eb 68                	jmp    7f7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 78f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 793:	75 1d                	jne    7b2 <printf+0x14e>
        putc(fd, *ap);
 795:	8b 45 e8             	mov    -0x18(%ebp),%eax
 798:	8b 00                	mov    (%eax),%eax
 79a:	0f be c0             	movsbl %al,%eax
 79d:	89 44 24 04          	mov    %eax,0x4(%esp)
 7a1:	8b 45 08             	mov    0x8(%ebp),%eax
 7a4:	89 04 24             	mov    %eax,(%esp)
 7a7:	e8 d8 fd ff ff       	call   584 <putc>
        ap++;
 7ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7b0:	eb 45                	jmp    7f7 <printf+0x193>
      } else if(c == '%'){
 7b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7b6:	75 17                	jne    7cf <printf+0x16b>
        putc(fd, c);
 7b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7bb:	0f be c0             	movsbl %al,%eax
 7be:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c2:	8b 45 08             	mov    0x8(%ebp),%eax
 7c5:	89 04 24             	mov    %eax,(%esp)
 7c8:	e8 b7 fd ff ff       	call   584 <putc>
 7cd:	eb 28                	jmp    7f7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7cf:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 7d6:	00 
 7d7:	8b 45 08             	mov    0x8(%ebp),%eax
 7da:	89 04 24             	mov    %eax,(%esp)
 7dd:	e8 a2 fd ff ff       	call   584 <putc>
        putc(fd, c);
 7e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e5:	0f be c0             	movsbl %al,%eax
 7e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ec:	8b 45 08             	mov    0x8(%ebp),%eax
 7ef:	89 04 24             	mov    %eax,(%esp)
 7f2:	e8 8d fd ff ff       	call   584 <putc>
      }
      state = 0;
 7f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 802:	8b 55 0c             	mov    0xc(%ebp),%edx
 805:	8b 45 f0             	mov    -0x10(%ebp),%eax
 808:	01 d0                	add    %edx,%eax
 80a:	0f b6 00             	movzbl (%eax),%eax
 80d:	84 c0                	test   %al,%al
 80f:	0f 85 71 fe ff ff    	jne    686 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 815:	c9                   	leave  
 816:	c3                   	ret    
 817:	90                   	nop

00000818 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 818:	55                   	push   %ebp
 819:	89 e5                	mov    %esp,%ebp
 81b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 81e:	8b 45 08             	mov    0x8(%ebp),%eax
 821:	83 e8 08             	sub    $0x8,%eax
 824:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 827:	a1 88 11 00 00       	mov    0x1188,%eax
 82c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 82f:	eb 24                	jmp    855 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 831:	8b 45 fc             	mov    -0x4(%ebp),%eax
 834:	8b 00                	mov    (%eax),%eax
 836:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 839:	77 12                	ja     84d <free+0x35>
 83b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 841:	77 24                	ja     867 <free+0x4f>
 843:	8b 45 fc             	mov    -0x4(%ebp),%eax
 846:	8b 00                	mov    (%eax),%eax
 848:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 84b:	77 1a                	ja     867 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	89 45 fc             	mov    %eax,-0x4(%ebp)
 855:	8b 45 f8             	mov    -0x8(%ebp),%eax
 858:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 85b:	76 d4                	jbe    831 <free+0x19>
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	8b 00                	mov    (%eax),%eax
 862:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 865:	76 ca                	jbe    831 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 867:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86a:	8b 40 04             	mov    0x4(%eax),%eax
 86d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 874:	8b 45 f8             	mov    -0x8(%ebp),%eax
 877:	01 c2                	add    %eax,%edx
 879:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87c:	8b 00                	mov    (%eax),%eax
 87e:	39 c2                	cmp    %eax,%edx
 880:	75 24                	jne    8a6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 882:	8b 45 f8             	mov    -0x8(%ebp),%eax
 885:	8b 50 04             	mov    0x4(%eax),%edx
 888:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88b:	8b 00                	mov    (%eax),%eax
 88d:	8b 40 04             	mov    0x4(%eax),%eax
 890:	01 c2                	add    %eax,%edx
 892:	8b 45 f8             	mov    -0x8(%ebp),%eax
 895:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 898:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	8b 10                	mov    (%eax),%edx
 89f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a2:	89 10                	mov    %edx,(%eax)
 8a4:	eb 0a                	jmp    8b0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a9:	8b 10                	mov    (%eax),%edx
 8ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ae:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b3:	8b 40 04             	mov    0x4(%eax),%eax
 8b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c0:	01 d0                	add    %edx,%eax
 8c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8c5:	75 20                	jne    8e7 <free+0xcf>
    p->s.size += bp->s.size;
 8c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ca:	8b 50 04             	mov    0x4(%eax),%edx
 8cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d0:	8b 40 04             	mov    0x4(%eax),%eax
 8d3:	01 c2                	add    %eax,%edx
 8d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8de:	8b 10                	mov    (%eax),%edx
 8e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e3:	89 10                	mov    %edx,(%eax)
 8e5:	eb 08                	jmp    8ef <free+0xd7>
  } else
    p->s.ptr = bp;
 8e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ea:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8ed:	89 10                	mov    %edx,(%eax)
  freep = p;
 8ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f2:	a3 88 11 00 00       	mov    %eax,0x1188
}
 8f7:	c9                   	leave  
 8f8:	c3                   	ret    

000008f9 <morecore>:

static Header*
morecore(uint nu)
{
 8f9:	55                   	push   %ebp
 8fa:	89 e5                	mov    %esp,%ebp
 8fc:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8ff:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 906:	77 07                	ja     90f <morecore+0x16>
    nu = 4096;
 908:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 90f:	8b 45 08             	mov    0x8(%ebp),%eax
 912:	c1 e0 03             	shl    $0x3,%eax
 915:	89 04 24             	mov    %eax,(%esp)
 918:	e8 27 fc ff ff       	call   544 <sbrk>
 91d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 920:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 924:	75 07                	jne    92d <morecore+0x34>
    return 0;
 926:	b8 00 00 00 00       	mov    $0x0,%eax
 92b:	eb 22                	jmp    94f <morecore+0x56>
  hp = (Header*)p;
 92d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 930:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 933:	8b 45 f0             	mov    -0x10(%ebp),%eax
 936:	8b 55 08             	mov    0x8(%ebp),%edx
 939:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 93c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93f:	83 c0 08             	add    $0x8,%eax
 942:	89 04 24             	mov    %eax,(%esp)
 945:	e8 ce fe ff ff       	call   818 <free>
  return freep;
 94a:	a1 88 11 00 00       	mov    0x1188,%eax
}
 94f:	c9                   	leave  
 950:	c3                   	ret    

00000951 <malloc>:

void*
malloc(uint nbytes)
{
 951:	55                   	push   %ebp
 952:	89 e5                	mov    %esp,%ebp
 954:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 957:	8b 45 08             	mov    0x8(%ebp),%eax
 95a:	83 c0 07             	add    $0x7,%eax
 95d:	c1 e8 03             	shr    $0x3,%eax
 960:	83 c0 01             	add    $0x1,%eax
 963:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 966:	a1 88 11 00 00       	mov    0x1188,%eax
 96b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 96e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 972:	75 23                	jne    997 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 974:	c7 45 f0 80 11 00 00 	movl   $0x1180,-0x10(%ebp)
 97b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97e:	a3 88 11 00 00       	mov    %eax,0x1188
 983:	a1 88 11 00 00       	mov    0x1188,%eax
 988:	a3 80 11 00 00       	mov    %eax,0x1180
    base.s.size = 0;
 98d:	c7 05 84 11 00 00 00 	movl   $0x0,0x1184
 994:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 997:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99a:	8b 00                	mov    (%eax),%eax
 99c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 99f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a2:	8b 40 04             	mov    0x4(%eax),%eax
 9a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9a8:	72 4d                	jb     9f7 <malloc+0xa6>
      if(p->s.size == nunits)
 9aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ad:	8b 40 04             	mov    0x4(%eax),%eax
 9b0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9b3:	75 0c                	jne    9c1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b8:	8b 10                	mov    (%eax),%edx
 9ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9bd:	89 10                	mov    %edx,(%eax)
 9bf:	eb 26                	jmp    9e7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 9c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c4:	8b 40 04             	mov    0x4(%eax),%eax
 9c7:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9ca:	89 c2                	mov    %eax,%edx
 9cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d5:	8b 40 04             	mov    0x4(%eax),%eax
 9d8:	c1 e0 03             	shl    $0x3,%eax
 9db:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9e4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ea:	a3 88 11 00 00       	mov    %eax,0x1188
      return (void*)(p + 1);
 9ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f2:	83 c0 08             	add    $0x8,%eax
 9f5:	eb 38                	jmp    a2f <malloc+0xde>
    }
    if(p == freep)
 9f7:	a1 88 11 00 00       	mov    0x1188,%eax
 9fc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9ff:	75 1b                	jne    a1c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a01:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a04:	89 04 24             	mov    %eax,(%esp)
 a07:	e8 ed fe ff ff       	call   8f9 <morecore>
 a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a13:	75 07                	jne    a1c <malloc+0xcb>
        return 0;
 a15:	b8 00 00 00 00       	mov    $0x0,%eax
 a1a:	eb 13                	jmp    a2f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a25:	8b 00                	mov    (%eax),%eax
 a27:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a2a:	e9 70 ff ff ff       	jmp    99f <malloc+0x4e>
}
 a2f:	c9                   	leave  
 a30:	c3                   	ret    
 a31:	66 90                	xchg   %ax,%ax
 a33:	90                   	nop

00000a34 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 a34:	55                   	push   %ebp
 a35:	89 e5                	mov    %esp,%ebp
 a37:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 a3a:	8b 55 08             	mov    0x8(%ebp),%edx
 a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
 a40:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a43:	f0 87 02             	lock xchg %eax,(%edx)
 a46:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 a49:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 a4c:	c9                   	leave  
 a4d:	c3                   	ret    

00000a4e <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 a4e:	55                   	push   %ebp
 a4f:	89 e5                	mov    %esp,%ebp
 a51:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 a54:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 a5b:	e8 f1 fe ff ff       	call   951 <malloc>
 a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a66:	85 c0                	test   %eax,%eax
 a68:	75 1b                	jne    a85 <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 a6a:	c7 44 24 04 f4 0c 00 	movl   $0xcf4,0x4(%esp)
 a71:	00 
 a72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a79:	e8 e6 fb ff ff       	call   664 <printf>
    return -1;
 a7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a83:	eb 43                	jmp    ac8 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a88:	25 ff 0f 00 00       	and    $0xfff,%eax
 a8d:	85 c0                	test   %eax,%eax
 a8f:	74 14                	je     aa5 <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a94:	25 ff 0f 00 00       	and    $0xfff,%eax
 a99:	89 c2                	mov    %eax,%edx
 a9b:	b8 00 10 00 00       	mov    $0x1000,%eax
 aa0:	29 d0                	sub    %edx,%eax
 aa2:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa8:	89 44 24 08          	mov    %eax,0x8(%esp)
 aac:	8b 45 14             	mov    0x14(%ebp),%eax
 aaf:	89 44 24 04          	mov    %eax,0x4(%esp)
 ab3:	8b 45 10             	mov    0x10(%ebp),%eax
 ab6:	89 04 24             	mov    %eax,(%esp)
 ab9:	e8 a6 fa ff ff       	call   564 <clone>
 abe:	8b 55 08             	mov    0x8(%ebp),%edx
 ac1:	89 02                	mov    %eax,(%edx)
  return *thread;
 ac3:	8b 45 08             	mov    0x8(%ebp),%eax
 ac6:	8b 00                	mov    (%eax),%eax
}
 ac8:	c9                   	leave  
 ac9:	c3                   	ret    

00000aca <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 aca:	55                   	push   %ebp
 acb:	89 e5                	mov    %esp,%ebp
 acd:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 ad0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 ad3:	89 44 24 04          	mov    %eax,0x4(%esp)
 ad7:	8b 45 08             	mov    0x8(%ebp),%eax
 ada:	89 04 24             	mov    %eax,(%esp)
 add:	e8 8a fa ff ff       	call   56c <join>
 ae2:	85 c0                	test   %eax,%eax
 ae4:	79 07                	jns    aed <pthread_join+0x23>
    return -1;
 ae6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 aeb:	eb 10                	jmp    afd <pthread_join+0x33>
  }
  free(stack);
 aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af0:	89 04 24             	mov    %eax,(%esp)
 af3:	e8 20 fd ff ff       	call   818 <free>
  return 0;
 af8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 afd:	c9                   	leave  
 afe:	c3                   	ret    

00000aff <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 aff:	55                   	push   %ebp
 b00:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 b02:	8b 45 08             	mov    0x8(%ebp),%eax
 b05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 b0b:	90                   	nop
}
 b0c:	5d                   	pop    %ebp
 b0d:	c3                   	ret    

00000b0e <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 b0e:	55                   	push   %ebp
 b0f:	89 e5                	mov    %esp,%ebp
 b11:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 b14:	90                   	nop
 b15:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 b1c:	00 
 b1d:	8b 45 08             	mov    0x8(%ebp),%eax
 b20:	89 04 24             	mov    %eax,(%esp)
 b23:	e8 0c ff ff ff       	call   a34 <xchg>
 b28:	85 c0                	test   %eax,%eax
 b2a:	75 e9                	jne    b15 <pthread_mutex_lock+0x7>
  return;
 b2c:	90                   	nop
}
 b2d:	c9                   	leave  
 b2e:	c3                   	ret    

00000b2f <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 b2f:	55                   	push   %ebp
 b30:	89 e5                	mov    %esp,%ebp
 b32:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 b35:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 b3c:	00 
 b3d:	8b 45 08             	mov    0x8(%ebp),%eax
 b40:	89 04 24             	mov    %eax,(%esp)
 b43:	e8 ec fe ff ff       	call   a34 <xchg>
  return;
 b48:	90                   	nop
}
 b49:	c9                   	leave  
 b4a:	c3                   	ret    

00000b4b <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 b4b:	55                   	push   %ebp
 b4c:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 b4e:	8b 45 08             	mov    0x8(%ebp),%eax
 b51:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 b57:	8b 45 08             	mov    0x8(%ebp),%eax
 b5a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 b61:	90                   	nop
}
 b62:	5d                   	pop    %ebp
 b63:	c3                   	ret    

00000b64 <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 b64:	55                   	push   %ebp
 b65:	89 e5                	mov    %esp,%ebp
 b67:	53                   	push   %ebx
 b68:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 b6b:	8b 45 08             	mov    0x8(%ebp),%eax
 b6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 b71:	8b 45 0c             	mov    0xc(%ebp),%eax
 b74:	89 04 24             	mov    %eax,(%esp)
 b77:	e8 b3 ff ff ff       	call   b2f <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 b7c:	eb 09                	jmp    b87 <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b81:	8b 40 04             	mov    0x4(%eax),%eax
 b84:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 b87:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b8a:	8b 40 04             	mov    0x4(%eax),%eax
 b8d:	85 c0                	test   %eax,%eax
 b8f:	75 ed                	jne    b7e <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 b91:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 b98:	e8 b4 fd ff ff       	call   951 <malloc>
 b9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ba0:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 ba3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba6:	8b 58 04             	mov    0x4(%eax),%ebx
 ba9:	e8 8e f9 ff ff       	call   53c <getpid>
 bae:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bb3:	8b 40 04             	mov    0x4(%eax),%eax
 bb6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 bbd:	8b 45 0c             	mov    0xc(%ebp),%eax
 bc0:	89 04 24             	mov    %eax,(%esp)
 bc3:	e8 46 ff ff ff       	call   b0e <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
 bcb:	89 04 24             	mov    %eax,(%esp)
 bce:	e8 5c ff ff ff       	call   b2f <pthread_mutex_unlock>
  threadSleep(mutex);
 bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
 bd6:	89 04 24             	mov    %eax,(%esp)
 bd9:	e8 96 f9 ff ff       	call   574 <threadSleep>
  pthread_mutex_lock(mutex);
 bde:	8b 45 0c             	mov    0xc(%ebp),%eax
 be1:	89 04 24             	mov    %eax,(%esp)
 be4:	e8 25 ff ff ff       	call   b0e <pthread_mutex_lock>
  return;
 be9:	90                   	nop
}
 bea:	83 c4 24             	add    $0x24,%esp
 bed:	5b                   	pop    %ebx
 bee:	5d                   	pop    %ebp
 bef:	c3                   	ret    

00000bf0 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 bf0:	55                   	push   %ebp
 bf1:	89 e5                	mov    %esp,%ebp
 bf3:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 bf6:	8b 45 08             	mov    0x8(%ebp),%eax
 bf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 bfc:	eb 09                	jmp    c07 <pthread_cond_signal+0x17>
    mycond = mycond->next;
 bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c01:	8b 40 04             	mov    0x4(%eax),%eax
 c04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c0a:	8b 00                	mov    (%eax),%eax
 c0c:	83 f8 ff             	cmp    $0xffffffff,%eax
 c0f:	74 ed                	je     bfe <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 c11:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c15:	74 33                	je     c4a <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c1a:	8b 00                	mov    (%eax),%eax
 c1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c22:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 c25:	8b 45 08             	mov    0x8(%ebp),%eax
 c28:	8b 40 04             	mov    0x4(%eax),%eax
 c2b:	8b 50 04             	mov    0x4(%eax),%edx
 c2e:	8b 45 08             	mov    0x8(%ebp),%eax
 c31:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 c34:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c37:	89 04 24             	mov    %eax,(%esp)
 c3a:	e8 d9 fb ff ff       	call   818 <free>
    threadWake(threadId);
 c3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c42:	89 04 24             	mov    %eax,(%esp)
 c45:	e8 32 f9 ff ff       	call   57c <threadWake>
  }
  return;
 c4a:	90                   	nop
}
 c4b:	c9                   	leave  
 c4c:	c3                   	ret    

00000c4d <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 c4d:	55                   	push   %ebp
 c4e:	89 e5                	mov    %esp,%ebp
 c50:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 c53:	8b 45 08             	mov    0x8(%ebp),%eax
 c56:	8b 55 10             	mov    0x10(%ebp),%edx
 c59:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 c5b:	8b 45 08             	mov    0x8(%ebp),%eax
 c5e:	83 c0 04             	add    $0x4,%eax
 c61:	89 04 24             	mov    %eax,(%esp)
 c64:	e8 e2 fe ff ff       	call   b4b <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 c69:	8b 45 08             	mov    0x8(%ebp),%eax
 c6c:	83 c0 0c             	add    $0xc,%eax
 c6f:	89 04 24             	mov    %eax,(%esp)
 c72:	e8 88 fe ff ff       	call   aff <pthread_mutex_init>
  return;
 c77:	90                   	nop
}
 c78:	c9                   	leave  
 c79:	c3                   	ret    

00000c7a <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 c7a:	55                   	push   %ebp
 c7b:	89 e5                	mov    %esp,%ebp
 c7d:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 c80:	8b 45 08             	mov    0x8(%ebp),%eax
 c83:	8b 00                	mov    (%eax),%eax
 c85:	8d 50 ff             	lea    -0x1(%eax),%edx
 c88:	8b 45 08             	mov    0x8(%ebp),%eax
 c8b:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 c8d:	8b 45 08             	mov    0x8(%ebp),%eax
 c90:	8b 00                	mov    (%eax),%eax
 c92:	85 c0                	test   %eax,%eax
 c94:	79 18                	jns    cae <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 c96:	8b 45 08             	mov    0x8(%ebp),%eax
 c99:	8d 50 0c             	lea    0xc(%eax),%edx
 c9c:	8b 45 08             	mov    0x8(%ebp),%eax
 c9f:	83 c0 04             	add    $0x4,%eax
 ca2:	89 54 24 04          	mov    %edx,0x4(%esp)
 ca6:	89 04 24             	mov    %eax,(%esp)
 ca9:	e8 b6 fe ff ff       	call   b64 <pthread_cond_wait>
  }
  return;
 cae:	90                   	nop
}
 caf:	c9                   	leave  
 cb0:	c3                   	ret    

00000cb1 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 cb1:	55                   	push   %ebp
 cb2:	89 e5                	mov    %esp,%ebp
 cb4:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 cb7:	8b 45 08             	mov    0x8(%ebp),%eax
 cba:	8b 00                	mov    (%eax),%eax
 cbc:	8d 50 01             	lea    0x1(%eax),%edx
 cbf:	8b 45 08             	mov    0x8(%ebp),%eax
 cc2:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 cc4:	8b 45 08             	mov    0x8(%ebp),%eax
 cc7:	83 c0 04             	add    $0x4,%eax
 cca:	89 04 24             	mov    %eax,(%esp)
 ccd:	e8 1e ff ff ff       	call   bf0 <pthread_cond_signal>
  return;
 cd2:	90                   	nop
}
 cd3:	c9                   	leave  
 cd4:	c3                   	ret    
