
_philosophers:     file format elf32-i386


Disassembly of section .text:

00000000 <left>:
#define NULL 0

mpthread_sem_t forks[5];
mpthread_mutex_t mutex;
int left(int p)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
    return p;
   3:	8b 45 08             	mov    0x8(%ebp),%eax
}
   6:	5d                   	pop    %ebp
   7:	c3                   	ret    

00000008 <right>:
int right(int p)
{
   8:	55                   	push   %ebp
   9:	89 e5                	mov    %esp,%ebp
    return (p + 1) % 5;
   b:	8b 45 08             	mov    0x8(%ebp),%eax
   e:	8d 48 01             	lea    0x1(%eax),%ecx
  11:	ba 67 66 66 66       	mov    $0x66666667,%edx
  16:	89 c8                	mov    %ecx,%eax
  18:	f7 ea                	imul   %edx
  1a:	d1 fa                	sar    %edx
  1c:	89 c8                	mov    %ecx,%eax
  1e:	c1 f8 1f             	sar    $0x1f,%eax
  21:	29 c2                	sub    %eax,%edx
  23:	89 d0                	mov    %edx,%eax
  25:	c1 e0 02             	shl    $0x2,%eax
  28:	01 d0                	add    %edx,%eax
  2a:	29 c1                	sub    %eax,%ecx
  2c:	89 ca                	mov    %ecx,%edx
  2e:	89 d0                	mov    %edx,%eax
}
  30:	5d                   	pop    %ebp
  31:	c3                   	ret    

00000032 <getForks>:
void getForks(int p)
{
  32:	55                   	push   %ebp
  33:	89 e5                	mov    %esp,%ebp
  35:	83 ec 18             	sub    $0x18,%esp
    pthread_mutex_lock(&mutex);
  38:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
  3f:	e8 12 0b 00 00       	call   b56 <pthread_mutex_lock>
    printf(1, "%d tries to get forks\n", p);
  44:	8b 45 08             	mov    0x8(%ebp),%eax
  47:	89 44 24 08          	mov    %eax,0x8(%esp)
  4b:	c7 44 24 04 20 0d 00 	movl   $0xd20,0x4(%esp)
  52:	00 
  53:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5a:	e8 4d 06 00 00       	call   6ac <printf>
    pthread_mutex_unlock(&mutex);
  5f:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
  66:	e8 0c 0b 00 00       	call   b77 <pthread_mutex_unlock>

    if(p == 4){
  6b:	83 7d 08 04          	cmpl   $0x4,0x8(%ebp)
  6f:	75 38                	jne    a9 <getForks+0x77>
      pthread_sem_wait(&forks[left(p)]);
  71:	8b 45 08             	mov    0x8(%ebp),%eax
  74:	89 04 24             	mov    %eax,(%esp)
  77:	e8 84 ff ff ff       	call   0 <left>
  7c:	c1 e0 04             	shl    $0x4,%eax
  7f:	05 60 12 00 00       	add    $0x1260,%eax
  84:	89 04 24             	mov    %eax,(%esp)
  87:	e8 36 0c 00 00       	call   cc2 <pthread_sem_wait>
      pthread_sem_wait(&forks[right(p)]);
  8c:	8b 45 08             	mov    0x8(%ebp),%eax
  8f:	89 04 24             	mov    %eax,(%esp)
  92:	e8 71 ff ff ff       	call   8 <right>
  97:	c1 e0 04             	shl    $0x4,%eax
  9a:	05 60 12 00 00       	add    $0x1260,%eax
  9f:	89 04 24             	mov    %eax,(%esp)
  a2:	e8 1b 0c 00 00       	call   cc2 <pthread_sem_wait>
  a7:	eb 36                	jmp    df <getForks+0xad>
    }
    else{
      pthread_sem_wait(&forks[right(p)]);
  a9:	8b 45 08             	mov    0x8(%ebp),%eax
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 54 ff ff ff       	call   8 <right>
  b4:	c1 e0 04             	shl    $0x4,%eax
  b7:	05 60 12 00 00       	add    $0x1260,%eax
  bc:	89 04 24             	mov    %eax,(%esp)
  bf:	e8 fe 0b 00 00       	call   cc2 <pthread_sem_wait>
      pthread_sem_wait(&forks[left(p)]);
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	89 04 24             	mov    %eax,(%esp)
  ca:	e8 31 ff ff ff       	call   0 <left>
  cf:	c1 e0 04             	shl    $0x4,%eax
  d2:	05 60 12 00 00       	add    $0x1260,%eax
  d7:	89 04 24             	mov    %eax,(%esp)
  da:	e8 e3 0b 00 00       	call   cc2 <pthread_sem_wait>
    }
    pthread_mutex_lock(&mutex);
  df:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
  e6:	e8 6b 0a 00 00       	call   b56 <pthread_mutex_lock>
    printf(1, "%d gets the forks\n", p);
  eb:	8b 45 08             	mov    0x8(%ebp),%eax
  ee:	89 44 24 08          	mov    %eax,0x8(%esp)
  f2:	c7 44 24 04 37 0d 00 	movl   $0xd37,0x4(%esp)
  f9:	00 
  fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 101:	e8 a6 05 00 00       	call   6ac <printf>
    pthread_mutex_unlock(&mutex);
 106:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
 10d:	e8 65 0a 00 00       	call   b77 <pthread_mutex_unlock>
}
 112:	c9                   	leave  
 113:	c3                   	ret    

00000114 <putForks>:
void putForks(int p)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	83 ec 18             	sub    $0x18,%esp
    pthread_mutex_lock(&mutex);
 11a:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
 121:	e8 30 0a 00 00       	call   b56 <pthread_mutex_lock>
    printf(1, "%d puts the forks\n", p);
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	89 44 24 08          	mov    %eax,0x8(%esp)
 12d:	c7 44 24 04 4a 0d 00 	movl   $0xd4a,0x4(%esp)
 134:	00 
 135:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13c:	e8 6b 05 00 00       	call   6ac <printf>
    pthread_mutex_unlock(&mutex);
 141:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
 148:	e8 2a 0a 00 00       	call   b77 <pthread_mutex_unlock>

    pthread_sem_post(&forks[left(p)]);
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	89 04 24             	mov    %eax,(%esp)
 153:	e8 a8 fe ff ff       	call   0 <left>
 158:	c1 e0 04             	shl    $0x4,%eax
 15b:	05 60 12 00 00       	add    $0x1260,%eax
 160:	89 04 24             	mov    %eax,(%esp)
 163:	e8 91 0b 00 00       	call   cf9 <pthread_sem_post>
    pthread_sem_post(&forks[right(p)]);
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	89 04 24             	mov    %eax,(%esp)
 16e:	e8 95 fe ff ff       	call   8 <right>
 173:	c1 e0 04             	shl    $0x4,%eax
 176:	05 60 12 00 00       	add    $0x1260,%eax
 17b:	89 04 24             	mov    %eax,(%esp)
 17e:	e8 76 0b 00 00       	call   cf9 <pthread_sem_post>
}
 183:	c9                   	leave  
 184:	c3                   	ret    

00000185 <philosopher>:
void philosopher(void *arg)
{
 185:	55                   	push   %ebp
 186:	89 e5                	mov    %esp,%ebp
 188:	83 ec 28             	sub    $0x28,%esp
    int i;
    long p = (long) arg;
 18b:	8b 45 08             	mov    0x8(%ebp),%eax
 18e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (1)
    {
        // Think
        for (i = 0; i < 100000; i++);
 191:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 198:	eb 04                	jmp    19e <philosopher+0x19>
 19a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 19e:	81 7d f4 9f 86 01 00 	cmpl   $0x1869f,-0xc(%ebp)
 1a5:	7e f3                	jle    19a <philosopher+0x15>
        // Get forks
        getForks(p);
 1a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1aa:	89 04 24             	mov    %eax,(%esp)
 1ad:	e8 80 fe ff ff       	call   32 <getForks>
        // Eat
        for (i = 0; i < 100000; i++);
 1b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1b9:	eb 04                	jmp    1bf <philosopher+0x3a>
 1bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1bf:	81 7d f4 9f 86 01 00 	cmpl   $0x1869f,-0xc(%ebp)
 1c6:	7e f3                	jle    1bb <philosopher+0x36>
        // Put forks
        putForks(p);
 1c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1cb:	89 04 24             	mov    %eax,(%esp)
 1ce:	e8 41 ff ff ff       	call   114 <putForks>
    }
 1d3:	eb bc                	jmp    191 <philosopher+0xc>

000001d5 <main>:
    exit();
}
int main()
{
 1d5:	55                   	push   %ebp
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	83 e4 f0             	and    $0xfffffff0,%esp
 1db:	83 ec 30             	sub    $0x30,%esp
    pthread_mutex_init(&mutex);
 1de:	c7 04 24 40 12 00 00 	movl   $0x1240,(%esp)
 1e5:	e8 5d 09 00 00       	call   b47 <pthread_mutex_init>
    // Initialize semaphores
    long i;
    for (i = 0; i < 5; i++)
 1ea:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
 1f1:	00 
 1f2:	eb 29                	jmp    21d <main+0x48>
        pthread_sem_init(&forks[i], 0, 1);
 1f4:	8b 44 24 2c          	mov    0x2c(%esp),%eax
 1f8:	c1 e0 04             	shl    $0x4,%eax
 1fb:	05 60 12 00 00       	add    $0x1260,%eax
 200:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 207:	00 
 208:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 20f:	00 
 210:	89 04 24             	mov    %eax,(%esp)
 213:	e8 7d 0a 00 00       	call   c95 <pthread_sem_init>
int main()
{
    pthread_mutex_init(&mutex);
    // Initialize semaphores
    long i;
    for (i = 0; i < 5; i++)
 218:	83 44 24 2c 01       	addl   $0x1,0x2c(%esp)
 21d:	83 7c 24 2c 04       	cmpl   $0x4,0x2c(%esp)
 222:	7e d0                	jle    1f4 <main+0x1f>
        pthread_sem_init(&forks[i], 0, 1);
    // Create child threads
    mpthread_t p[5];
    for (i = 0; i < 5; i++)
 224:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
 22b:	00 
 22c:	eb 32                	jmp    260 <main+0x8b>
        pthread_create(&p[i], NULL, philosopher, (void *) i);
 22e:	8b 44 24 2c          	mov    0x2c(%esp),%eax
 232:	8d 54 24 18          	lea    0x18(%esp),%edx
 236:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
 23a:	c1 e1 02             	shl    $0x2,%ecx
 23d:	01 ca                	add    %ecx,%edx
 23f:	89 44 24 0c          	mov    %eax,0xc(%esp)
 243:	c7 44 24 08 85 01 00 	movl   $0x185,0x8(%esp)
 24a:	00 
 24b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 252:	00 
 253:	89 14 24             	mov    %edx,(%esp)
 256:	e8 3b 08 00 00       	call   a96 <pthread_create>
    long i;
    for (i = 0; i < 5; i++)
        pthread_sem_init(&forks[i], 0, 1);
    // Create child threads
    mpthread_t p[5];
    for (i = 0; i < 5; i++)
 25b:	83 44 24 2c 01       	addl   $0x1,0x2c(%esp)
 260:	83 7c 24 2c 04       	cmpl   $0x4,0x2c(%esp)
 265:	7e c7                	jle    22e <main+0x59>
        pthread_create(&p[i], NULL, philosopher, (void *) i);
    // Wait for children
    for (i = 0; i < 5; i++)
 267:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
 26e:	00 
 26f:	eb 1d                	jmp    28e <main+0xb9>
        pthread_join(p[i], NULL);
 271:	8b 44 24 2c          	mov    0x2c(%esp),%eax
 275:	8b 44 84 18          	mov    0x18(%esp,%eax,4),%eax
 279:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 280:	00 
 281:	89 04 24             	mov    %eax,(%esp)
 284:	e8 89 08 00 00       	call   b12 <pthread_join>
    // Create child threads
    mpthread_t p[5];
    for (i = 0; i < 5; i++)
        pthread_create(&p[i], NULL, philosopher, (void *) i);
    // Wait for children
    for (i = 0; i < 5; i++)
 289:	83 44 24 2c 01       	addl   $0x1,0x2c(%esp)
 28e:	83 7c 24 2c 04       	cmpl   $0x4,0x2c(%esp)
 293:	7e dc                	jle    271 <main+0x9c>
        pthread_join(p[i], NULL);
    // Done
    return 0;
 295:	b8 00 00 00 00       	mov    $0x0,%eax
}
 29a:	c9                   	leave  
 29b:	c3                   	ret    

0000029c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 29c:	55                   	push   %ebp
 29d:	89 e5                	mov    %esp,%ebp
 29f:	57                   	push   %edi
 2a0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 2a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2a4:	8b 55 10             	mov    0x10(%ebp),%edx
 2a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2aa:	89 cb                	mov    %ecx,%ebx
 2ac:	89 df                	mov    %ebx,%edi
 2ae:	89 d1                	mov    %edx,%ecx
 2b0:	fc                   	cld    
 2b1:	f3 aa                	rep stos %al,%es:(%edi)
 2b3:	89 ca                	mov    %ecx,%edx
 2b5:	89 fb                	mov    %edi,%ebx
 2b7:	89 5d 08             	mov    %ebx,0x8(%ebp)
 2ba:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 2bd:	5b                   	pop    %ebx
 2be:	5f                   	pop    %edi
 2bf:	5d                   	pop    %ebp
 2c0:	c3                   	ret    

000002c1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2c1:	55                   	push   %ebp
 2c2:	89 e5                	mov    %esp,%ebp
 2c4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 2cd:	90                   	nop
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	8d 50 01             	lea    0x1(%eax),%edx
 2d4:	89 55 08             	mov    %edx,0x8(%ebp)
 2d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 2da:	8d 4a 01             	lea    0x1(%edx),%ecx
 2dd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 2e0:	0f b6 12             	movzbl (%edx),%edx
 2e3:	88 10                	mov    %dl,(%eax)
 2e5:	0f b6 00             	movzbl (%eax),%eax
 2e8:	84 c0                	test   %al,%al
 2ea:	75 e2                	jne    2ce <strcpy+0xd>
    ;
  return os;
 2ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2ef:	c9                   	leave  
 2f0:	c3                   	ret    

000002f1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f1:	55                   	push   %ebp
 2f2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 2f4:	eb 08                	jmp    2fe <strcmp+0xd>
    p++, q++;
 2f6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2fa:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2fe:	8b 45 08             	mov    0x8(%ebp),%eax
 301:	0f b6 00             	movzbl (%eax),%eax
 304:	84 c0                	test   %al,%al
 306:	74 10                	je     318 <strcmp+0x27>
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	0f b6 10             	movzbl (%eax),%edx
 30e:	8b 45 0c             	mov    0xc(%ebp),%eax
 311:	0f b6 00             	movzbl (%eax),%eax
 314:	38 c2                	cmp    %al,%dl
 316:	74 de                	je     2f6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	0f b6 00             	movzbl (%eax),%eax
 31e:	0f b6 d0             	movzbl %al,%edx
 321:	8b 45 0c             	mov    0xc(%ebp),%eax
 324:	0f b6 00             	movzbl (%eax),%eax
 327:	0f b6 c0             	movzbl %al,%eax
 32a:	29 c2                	sub    %eax,%edx
 32c:	89 d0                	mov    %edx,%eax
}
 32e:	5d                   	pop    %ebp
 32f:	c3                   	ret    

00000330 <strlen>:

uint
strlen(char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 336:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 33d:	eb 04                	jmp    343 <strlen+0x13>
 33f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 343:	8b 55 fc             	mov    -0x4(%ebp),%edx
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	01 d0                	add    %edx,%eax
 34b:	0f b6 00             	movzbl (%eax),%eax
 34e:	84 c0                	test   %al,%al
 350:	75 ed                	jne    33f <strlen+0xf>
    ;
  return n;
 352:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 355:	c9                   	leave  
 356:	c3                   	ret    

00000357 <memset>:

void*
memset(void *dst, int c, uint n)
{
 357:	55                   	push   %ebp
 358:	89 e5                	mov    %esp,%ebp
 35a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 35d:	8b 45 10             	mov    0x10(%ebp),%eax
 360:	89 44 24 08          	mov    %eax,0x8(%esp)
 364:	8b 45 0c             	mov    0xc(%ebp),%eax
 367:	89 44 24 04          	mov    %eax,0x4(%esp)
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
 36e:	89 04 24             	mov    %eax,(%esp)
 371:	e8 26 ff ff ff       	call   29c <stosb>
  return dst;
 376:	8b 45 08             	mov    0x8(%ebp),%eax
}
 379:	c9                   	leave  
 37a:	c3                   	ret    

0000037b <strchr>:

char*
strchr(const char *s, char c)
{
 37b:	55                   	push   %ebp
 37c:	89 e5                	mov    %esp,%ebp
 37e:	83 ec 04             	sub    $0x4,%esp
 381:	8b 45 0c             	mov    0xc(%ebp),%eax
 384:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 387:	eb 14                	jmp    39d <strchr+0x22>
    if(*s == c)
 389:	8b 45 08             	mov    0x8(%ebp),%eax
 38c:	0f b6 00             	movzbl (%eax),%eax
 38f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 392:	75 05                	jne    399 <strchr+0x1e>
      return (char*)s;
 394:	8b 45 08             	mov    0x8(%ebp),%eax
 397:	eb 13                	jmp    3ac <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 399:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 39d:	8b 45 08             	mov    0x8(%ebp),%eax
 3a0:	0f b6 00             	movzbl (%eax),%eax
 3a3:	84 c0                	test   %al,%al
 3a5:	75 e2                	jne    389 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 3a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3ac:	c9                   	leave  
 3ad:	c3                   	ret    

000003ae <gets>:

char*
gets(char *buf, int max)
{
 3ae:	55                   	push   %ebp
 3af:	89 e5                	mov    %esp,%ebp
 3b1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3bb:	eb 4c                	jmp    409 <gets+0x5b>
    cc = read(0, &c, 1);
 3bd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3c4:	00 
 3c5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 3c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 3cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3d3:	e8 44 01 00 00       	call   51c <read>
 3d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 3db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3df:	7f 02                	jg     3e3 <gets+0x35>
      break;
 3e1:	eb 31                	jmp    414 <gets+0x66>
    buf[i++] = c;
 3e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e6:	8d 50 01             	lea    0x1(%eax),%edx
 3e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ec:	89 c2                	mov    %eax,%edx
 3ee:	8b 45 08             	mov    0x8(%ebp),%eax
 3f1:	01 c2                	add    %eax,%edx
 3f3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3f7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 3f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3fd:	3c 0a                	cmp    $0xa,%al
 3ff:	74 13                	je     414 <gets+0x66>
 401:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 405:	3c 0d                	cmp    $0xd,%al
 407:	74 0b                	je     414 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 409:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40c:	83 c0 01             	add    $0x1,%eax
 40f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 412:	7c a9                	jl     3bd <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 414:	8b 55 f4             	mov    -0xc(%ebp),%edx
 417:	8b 45 08             	mov    0x8(%ebp),%eax
 41a:	01 d0                	add    %edx,%eax
 41c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 41f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 422:	c9                   	leave  
 423:	c3                   	ret    

00000424 <stat>:

int
stat(char *n, struct stat *st)
{
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 42a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 431:	00 
 432:	8b 45 08             	mov    0x8(%ebp),%eax
 435:	89 04 24             	mov    %eax,(%esp)
 438:	e8 07 01 00 00       	call   544 <open>
 43d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 440:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 444:	79 07                	jns    44d <stat+0x29>
    return -1;
 446:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 44b:	eb 23                	jmp    470 <stat+0x4c>
  r = fstat(fd, st);
 44d:	8b 45 0c             	mov    0xc(%ebp),%eax
 450:	89 44 24 04          	mov    %eax,0x4(%esp)
 454:	8b 45 f4             	mov    -0xc(%ebp),%eax
 457:	89 04 24             	mov    %eax,(%esp)
 45a:	e8 fd 00 00 00       	call   55c <fstat>
 45f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 462:	8b 45 f4             	mov    -0xc(%ebp),%eax
 465:	89 04 24             	mov    %eax,(%esp)
 468:	e8 bf 00 00 00       	call   52c <close>
  return r;
 46d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 470:	c9                   	leave  
 471:	c3                   	ret    

00000472 <atoi>:

int
atoi(const char *s)
{
 472:	55                   	push   %ebp
 473:	89 e5                	mov    %esp,%ebp
 475:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 478:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 47f:	eb 25                	jmp    4a6 <atoi+0x34>
    n = n*10 + *s++ - '0';
 481:	8b 55 fc             	mov    -0x4(%ebp),%edx
 484:	89 d0                	mov    %edx,%eax
 486:	c1 e0 02             	shl    $0x2,%eax
 489:	01 d0                	add    %edx,%eax
 48b:	01 c0                	add    %eax,%eax
 48d:	89 c1                	mov    %eax,%ecx
 48f:	8b 45 08             	mov    0x8(%ebp),%eax
 492:	8d 50 01             	lea    0x1(%eax),%edx
 495:	89 55 08             	mov    %edx,0x8(%ebp)
 498:	0f b6 00             	movzbl (%eax),%eax
 49b:	0f be c0             	movsbl %al,%eax
 49e:	01 c8                	add    %ecx,%eax
 4a0:	83 e8 30             	sub    $0x30,%eax
 4a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
 4a9:	0f b6 00             	movzbl (%eax),%eax
 4ac:	3c 2f                	cmp    $0x2f,%al
 4ae:	7e 0a                	jle    4ba <atoi+0x48>
 4b0:	8b 45 08             	mov    0x8(%ebp),%eax
 4b3:	0f b6 00             	movzbl (%eax),%eax
 4b6:	3c 39                	cmp    $0x39,%al
 4b8:	7e c7                	jle    481 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 4ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 4bd:	c9                   	leave  
 4be:	c3                   	ret    

000004bf <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4bf:	55                   	push   %ebp
 4c0:	89 e5                	mov    %esp,%ebp
 4c2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 4c5:	8b 45 08             	mov    0x8(%ebp),%eax
 4c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 4cb:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 4d1:	eb 17                	jmp    4ea <memmove+0x2b>
    *dst++ = *src++;
 4d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 4d6:	8d 50 01             	lea    0x1(%eax),%edx
 4d9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 4dc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 4df:	8d 4a 01             	lea    0x1(%edx),%ecx
 4e2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 4e5:	0f b6 12             	movzbl (%edx),%edx
 4e8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ea:	8b 45 10             	mov    0x10(%ebp),%eax
 4ed:	8d 50 ff             	lea    -0x1(%eax),%edx
 4f0:	89 55 10             	mov    %edx,0x10(%ebp)
 4f3:	85 c0                	test   %eax,%eax
 4f5:	7f dc                	jg     4d3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 4f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4fa:	c9                   	leave  
 4fb:	c3                   	ret    

000004fc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4fc:	b8 01 00 00 00       	mov    $0x1,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <exit>:
SYSCALL(exit)
 504:	b8 02 00 00 00       	mov    $0x2,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <wait>:
SYSCALL(wait)
 50c:	b8 03 00 00 00       	mov    $0x3,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <pipe>:
SYSCALL(pipe)
 514:	b8 04 00 00 00       	mov    $0x4,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <read>:
SYSCALL(read)
 51c:	b8 05 00 00 00       	mov    $0x5,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <write>:
SYSCALL(write)
 524:	b8 10 00 00 00       	mov    $0x10,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <close>:
SYSCALL(close)
 52c:	b8 15 00 00 00       	mov    $0x15,%eax
 531:	cd 40                	int    $0x40
 533:	c3                   	ret    

00000534 <kill>:
SYSCALL(kill)
 534:	b8 06 00 00 00       	mov    $0x6,%eax
 539:	cd 40                	int    $0x40
 53b:	c3                   	ret    

0000053c <exec>:
SYSCALL(exec)
 53c:	b8 07 00 00 00       	mov    $0x7,%eax
 541:	cd 40                	int    $0x40
 543:	c3                   	ret    

00000544 <open>:
SYSCALL(open)
 544:	b8 0f 00 00 00       	mov    $0xf,%eax
 549:	cd 40                	int    $0x40
 54b:	c3                   	ret    

0000054c <mknod>:
SYSCALL(mknod)
 54c:	b8 11 00 00 00       	mov    $0x11,%eax
 551:	cd 40                	int    $0x40
 553:	c3                   	ret    

00000554 <unlink>:
SYSCALL(unlink)
 554:	b8 12 00 00 00       	mov    $0x12,%eax
 559:	cd 40                	int    $0x40
 55b:	c3                   	ret    

0000055c <fstat>:
SYSCALL(fstat)
 55c:	b8 08 00 00 00       	mov    $0x8,%eax
 561:	cd 40                	int    $0x40
 563:	c3                   	ret    

00000564 <link>:
SYSCALL(link)
 564:	b8 13 00 00 00       	mov    $0x13,%eax
 569:	cd 40                	int    $0x40
 56b:	c3                   	ret    

0000056c <mkdir>:
SYSCALL(mkdir)
 56c:	b8 14 00 00 00       	mov    $0x14,%eax
 571:	cd 40                	int    $0x40
 573:	c3                   	ret    

00000574 <chdir>:
SYSCALL(chdir)
 574:	b8 09 00 00 00       	mov    $0x9,%eax
 579:	cd 40                	int    $0x40
 57b:	c3                   	ret    

0000057c <dup>:
SYSCALL(dup)
 57c:	b8 0a 00 00 00       	mov    $0xa,%eax
 581:	cd 40                	int    $0x40
 583:	c3                   	ret    

00000584 <getpid>:
SYSCALL(getpid)
 584:	b8 0b 00 00 00       	mov    $0xb,%eax
 589:	cd 40                	int    $0x40
 58b:	c3                   	ret    

0000058c <sbrk>:
SYSCALL(sbrk)
 58c:	b8 0c 00 00 00       	mov    $0xc,%eax
 591:	cd 40                	int    $0x40
 593:	c3                   	ret    

00000594 <sleep>:
SYSCALL(sleep)
 594:	b8 0d 00 00 00       	mov    $0xd,%eax
 599:	cd 40                	int    $0x40
 59b:	c3                   	ret    

0000059c <uptime>:
SYSCALL(uptime)
 59c:	b8 0e 00 00 00       	mov    $0xe,%eax
 5a1:	cd 40                	int    $0x40
 5a3:	c3                   	ret    

000005a4 <date>:
SYSCALL(date)
 5a4:	b8 16 00 00 00       	mov    $0x16,%eax
 5a9:	cd 40                	int    $0x40
 5ab:	c3                   	ret    

000005ac <clone>:
SYSCALL(clone)
 5ac:	b8 17 00 00 00       	mov    $0x17,%eax
 5b1:	cd 40                	int    $0x40
 5b3:	c3                   	ret    

000005b4 <join>:
SYSCALL(join)
 5b4:	b8 18 00 00 00       	mov    $0x18,%eax
 5b9:	cd 40                	int    $0x40
 5bb:	c3                   	ret    

000005bc <threadSleep>:
SYSCALL(threadSleep)
 5bc:	b8 19 00 00 00       	mov    $0x19,%eax
 5c1:	cd 40                	int    $0x40
 5c3:	c3                   	ret    

000005c4 <threadWake>:
SYSCALL(threadWake)
 5c4:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5c9:	cd 40                	int    $0x40
 5cb:	c3                   	ret    

000005cc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5cc:	55                   	push   %ebp
 5cd:	89 e5                	mov    %esp,%ebp
 5cf:	83 ec 18             	sub    $0x18,%esp
 5d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 5d5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5df:	00 
 5e0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ea:	89 04 24             	mov    %eax,(%esp)
 5ed:	e8 32 ff ff ff       	call   524 <write>
}
 5f2:	c9                   	leave  
 5f3:	c3                   	ret    

000005f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f4:	55                   	push   %ebp
 5f5:	89 e5                	mov    %esp,%ebp
 5f7:	56                   	push   %esi
 5f8:	53                   	push   %ebx
 5f9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 603:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 607:	74 17                	je     620 <printint+0x2c>
 609:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 60d:	79 11                	jns    620 <printint+0x2c>
    neg = 1;
 60f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 616:	8b 45 0c             	mov    0xc(%ebp),%eax
 619:	f7 d8                	neg    %eax
 61b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 61e:	eb 06                	jmp    626 <printint+0x32>
  } else {
    x = xx;
 620:	8b 45 0c             	mov    0xc(%ebp),%eax
 623:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 626:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 62d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 630:	8d 41 01             	lea    0x1(%ecx),%eax
 633:	89 45 f4             	mov    %eax,-0xc(%ebp)
 636:	8b 5d 10             	mov    0x10(%ebp),%ebx
 639:	8b 45 ec             	mov    -0x14(%ebp),%eax
 63c:	ba 00 00 00 00       	mov    $0x0,%edx
 641:	f7 f3                	div    %ebx
 643:	89 d0                	mov    %edx,%eax
 645:	0f b6 80 f8 11 00 00 	movzbl 0x11f8(%eax),%eax
 64c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 650:	8b 75 10             	mov    0x10(%ebp),%esi
 653:	8b 45 ec             	mov    -0x14(%ebp),%eax
 656:	ba 00 00 00 00       	mov    $0x0,%edx
 65b:	f7 f6                	div    %esi
 65d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 660:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 664:	75 c7                	jne    62d <printint+0x39>
  if(neg)
 666:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 66a:	74 10                	je     67c <printint+0x88>
    buf[i++] = '-';
 66c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66f:	8d 50 01             	lea    0x1(%eax),%edx
 672:	89 55 f4             	mov    %edx,-0xc(%ebp)
 675:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 67a:	eb 1f                	jmp    69b <printint+0xa7>
 67c:	eb 1d                	jmp    69b <printint+0xa7>
    putc(fd, buf[i]);
 67e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 681:	8b 45 f4             	mov    -0xc(%ebp),%eax
 684:	01 d0                	add    %edx,%eax
 686:	0f b6 00             	movzbl (%eax),%eax
 689:	0f be c0             	movsbl %al,%eax
 68c:	89 44 24 04          	mov    %eax,0x4(%esp)
 690:	8b 45 08             	mov    0x8(%ebp),%eax
 693:	89 04 24             	mov    %eax,(%esp)
 696:	e8 31 ff ff ff       	call   5cc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 69b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 69f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a3:	79 d9                	jns    67e <printint+0x8a>
    putc(fd, buf[i]);
}
 6a5:	83 c4 30             	add    $0x30,%esp
 6a8:	5b                   	pop    %ebx
 6a9:	5e                   	pop    %esi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret    

000006ac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6ac:	55                   	push   %ebp
 6ad:	89 e5                	mov    %esp,%ebp
 6af:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6b9:	8d 45 0c             	lea    0xc(%ebp),%eax
 6bc:	83 c0 04             	add    $0x4,%eax
 6bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6c9:	e9 7c 01 00 00       	jmp    84a <printf+0x19e>
    c = fmt[i] & 0xff;
 6ce:	8b 55 0c             	mov    0xc(%ebp),%edx
 6d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d4:	01 d0                	add    %edx,%eax
 6d6:	0f b6 00             	movzbl (%eax),%eax
 6d9:	0f be c0             	movsbl %al,%eax
 6dc:	25 ff 00 00 00       	and    $0xff,%eax
 6e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6e8:	75 2c                	jne    716 <printf+0x6a>
      if(c == '%'){
 6ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6ee:	75 0c                	jne    6fc <printf+0x50>
        state = '%';
 6f0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6f7:	e9 4a 01 00 00       	jmp    846 <printf+0x19a>
      } else {
        putc(fd, c);
 6fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ff:	0f be c0             	movsbl %al,%eax
 702:	89 44 24 04          	mov    %eax,0x4(%esp)
 706:	8b 45 08             	mov    0x8(%ebp),%eax
 709:	89 04 24             	mov    %eax,(%esp)
 70c:	e8 bb fe ff ff       	call   5cc <putc>
 711:	e9 30 01 00 00       	jmp    846 <printf+0x19a>
      }
    } else if(state == '%'){
 716:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 71a:	0f 85 26 01 00 00    	jne    846 <printf+0x19a>
      if(c == 'd'){
 720:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 724:	75 2d                	jne    753 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 726:	8b 45 e8             	mov    -0x18(%ebp),%eax
 729:	8b 00                	mov    (%eax),%eax
 72b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 732:	00 
 733:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 73a:	00 
 73b:	89 44 24 04          	mov    %eax,0x4(%esp)
 73f:	8b 45 08             	mov    0x8(%ebp),%eax
 742:	89 04 24             	mov    %eax,(%esp)
 745:	e8 aa fe ff ff       	call   5f4 <printint>
        ap++;
 74a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 74e:	e9 ec 00 00 00       	jmp    83f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 753:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 757:	74 06                	je     75f <printf+0xb3>
 759:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 75d:	75 2d                	jne    78c <printf+0xe0>
        printint(fd, *ap, 16, 0);
 75f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 76b:	00 
 76c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 773:	00 
 774:	89 44 24 04          	mov    %eax,0x4(%esp)
 778:	8b 45 08             	mov    0x8(%ebp),%eax
 77b:	89 04 24             	mov    %eax,(%esp)
 77e:	e8 71 fe ff ff       	call   5f4 <printint>
        ap++;
 783:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 787:	e9 b3 00 00 00       	jmp    83f <printf+0x193>
      } else if(c == 's'){
 78c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 790:	75 45                	jne    7d7 <printf+0x12b>
        s = (char*)*ap;
 792:	8b 45 e8             	mov    -0x18(%ebp),%eax
 795:	8b 00                	mov    (%eax),%eax
 797:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 79a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 79e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a2:	75 09                	jne    7ad <printf+0x101>
          s = "(null)";
 7a4:	c7 45 f4 5d 0d 00 00 	movl   $0xd5d,-0xc(%ebp)
        while(*s != 0){
 7ab:	eb 1e                	jmp    7cb <printf+0x11f>
 7ad:	eb 1c                	jmp    7cb <printf+0x11f>
          putc(fd, *s);
 7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b2:	0f b6 00             	movzbl (%eax),%eax
 7b5:	0f be c0             	movsbl %al,%eax
 7b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bc:	8b 45 08             	mov    0x8(%ebp),%eax
 7bf:	89 04 24             	mov    %eax,(%esp)
 7c2:	e8 05 fe ff ff       	call   5cc <putc>
          s++;
 7c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	0f b6 00             	movzbl (%eax),%eax
 7d1:	84 c0                	test   %al,%al
 7d3:	75 da                	jne    7af <printf+0x103>
 7d5:	eb 68                	jmp    83f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7d7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7db:	75 1d                	jne    7fa <printf+0x14e>
        putc(fd, *ap);
 7dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7e0:	8b 00                	mov    (%eax),%eax
 7e2:	0f be c0             	movsbl %al,%eax
 7e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ec:	89 04 24             	mov    %eax,(%esp)
 7ef:	e8 d8 fd ff ff       	call   5cc <putc>
        ap++;
 7f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f8:	eb 45                	jmp    83f <printf+0x193>
      } else if(c == '%'){
 7fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7fe:	75 17                	jne    817 <printf+0x16b>
        putc(fd, c);
 800:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 803:	0f be c0             	movsbl %al,%eax
 806:	89 44 24 04          	mov    %eax,0x4(%esp)
 80a:	8b 45 08             	mov    0x8(%ebp),%eax
 80d:	89 04 24             	mov    %eax,(%esp)
 810:	e8 b7 fd ff ff       	call   5cc <putc>
 815:	eb 28                	jmp    83f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 817:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 81e:	00 
 81f:	8b 45 08             	mov    0x8(%ebp),%eax
 822:	89 04 24             	mov    %eax,(%esp)
 825:	e8 a2 fd ff ff       	call   5cc <putc>
        putc(fd, c);
 82a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 82d:	0f be c0             	movsbl %al,%eax
 830:	89 44 24 04          	mov    %eax,0x4(%esp)
 834:	8b 45 08             	mov    0x8(%ebp),%eax
 837:	89 04 24             	mov    %eax,(%esp)
 83a:	e8 8d fd ff ff       	call   5cc <putc>
      }
      state = 0;
 83f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 846:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 84a:	8b 55 0c             	mov    0xc(%ebp),%edx
 84d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 850:	01 d0                	add    %edx,%eax
 852:	0f b6 00             	movzbl (%eax),%eax
 855:	84 c0                	test   %al,%al
 857:	0f 85 71 fe ff ff    	jne    6ce <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 85d:	c9                   	leave  
 85e:	c3                   	ret    
 85f:	90                   	nop

00000860 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 866:	8b 45 08             	mov    0x8(%ebp),%eax
 869:	83 e8 08             	sub    $0x8,%eax
 86c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86f:	a1 28 12 00 00       	mov    0x1228,%eax
 874:	89 45 fc             	mov    %eax,-0x4(%ebp)
 877:	eb 24                	jmp    89d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 879:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87c:	8b 00                	mov    (%eax),%eax
 87e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 881:	77 12                	ja     895 <free+0x35>
 883:	8b 45 f8             	mov    -0x8(%ebp),%eax
 886:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 889:	77 24                	ja     8af <free+0x4f>
 88b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88e:	8b 00                	mov    (%eax),%eax
 890:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 893:	77 1a                	ja     8af <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 895:	8b 45 fc             	mov    -0x4(%ebp),%eax
 898:	8b 00                	mov    (%eax),%eax
 89a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 89d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8a3:	76 d4                	jbe    879 <free+0x19>
 8a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a8:	8b 00                	mov    (%eax),%eax
 8aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ad:	76 ca                	jbe    879 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b2:	8b 40 04             	mov    0x4(%eax),%eax
 8b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bf:	01 c2                	add    %eax,%edx
 8c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c4:	8b 00                	mov    (%eax),%eax
 8c6:	39 c2                	cmp    %eax,%edx
 8c8:	75 24                	jne    8ee <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8cd:	8b 50 04             	mov    0x4(%eax),%edx
 8d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d3:	8b 00                	mov    (%eax),%eax
 8d5:	8b 40 04             	mov    0x4(%eax),%eax
 8d8:	01 c2                	add    %eax,%edx
 8da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8dd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e3:	8b 00                	mov    (%eax),%eax
 8e5:	8b 10                	mov    (%eax),%edx
 8e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ea:	89 10                	mov    %edx,(%eax)
 8ec:	eb 0a                	jmp    8f8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f1:	8b 10                	mov    (%eax),%edx
 8f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fb:	8b 40 04             	mov    0x4(%eax),%eax
 8fe:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 905:	8b 45 fc             	mov    -0x4(%ebp),%eax
 908:	01 d0                	add    %edx,%eax
 90a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 90d:	75 20                	jne    92f <free+0xcf>
    p->s.size += bp->s.size;
 90f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 912:	8b 50 04             	mov    0x4(%eax),%edx
 915:	8b 45 f8             	mov    -0x8(%ebp),%eax
 918:	8b 40 04             	mov    0x4(%eax),%eax
 91b:	01 c2                	add    %eax,%edx
 91d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 920:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 923:	8b 45 f8             	mov    -0x8(%ebp),%eax
 926:	8b 10                	mov    (%eax),%edx
 928:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92b:	89 10                	mov    %edx,(%eax)
 92d:	eb 08                	jmp    937 <free+0xd7>
  } else
    p->s.ptr = bp;
 92f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 932:	8b 55 f8             	mov    -0x8(%ebp),%edx
 935:	89 10                	mov    %edx,(%eax)
  freep = p;
 937:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93a:	a3 28 12 00 00       	mov    %eax,0x1228
}
 93f:	c9                   	leave  
 940:	c3                   	ret    

00000941 <morecore>:

static Header*
morecore(uint nu)
{
 941:	55                   	push   %ebp
 942:	89 e5                	mov    %esp,%ebp
 944:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 947:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 94e:	77 07                	ja     957 <morecore+0x16>
    nu = 4096;
 950:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 957:	8b 45 08             	mov    0x8(%ebp),%eax
 95a:	c1 e0 03             	shl    $0x3,%eax
 95d:	89 04 24             	mov    %eax,(%esp)
 960:	e8 27 fc ff ff       	call   58c <sbrk>
 965:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 968:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 96c:	75 07                	jne    975 <morecore+0x34>
    return 0;
 96e:	b8 00 00 00 00       	mov    $0x0,%eax
 973:	eb 22                	jmp    997 <morecore+0x56>
  hp = (Header*)p;
 975:	8b 45 f4             	mov    -0xc(%ebp),%eax
 978:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 97b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97e:	8b 55 08             	mov    0x8(%ebp),%edx
 981:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 984:	8b 45 f0             	mov    -0x10(%ebp),%eax
 987:	83 c0 08             	add    $0x8,%eax
 98a:	89 04 24             	mov    %eax,(%esp)
 98d:	e8 ce fe ff ff       	call   860 <free>
  return freep;
 992:	a1 28 12 00 00       	mov    0x1228,%eax
}
 997:	c9                   	leave  
 998:	c3                   	ret    

00000999 <malloc>:

void*
malloc(uint nbytes)
{
 999:	55                   	push   %ebp
 99a:	89 e5                	mov    %esp,%ebp
 99c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99f:	8b 45 08             	mov    0x8(%ebp),%eax
 9a2:	83 c0 07             	add    $0x7,%eax
 9a5:	c1 e8 03             	shr    $0x3,%eax
 9a8:	83 c0 01             	add    $0x1,%eax
 9ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9ae:	a1 28 12 00 00       	mov    0x1228,%eax
 9b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9ba:	75 23                	jne    9df <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9bc:	c7 45 f0 20 12 00 00 	movl   $0x1220,-0x10(%ebp)
 9c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c6:	a3 28 12 00 00       	mov    %eax,0x1228
 9cb:	a1 28 12 00 00       	mov    0x1228,%eax
 9d0:	a3 20 12 00 00       	mov    %eax,0x1220
    base.s.size = 0;
 9d5:	c7 05 24 12 00 00 00 	movl   $0x0,0x1224
 9dc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e2:	8b 00                	mov    (%eax),%eax
 9e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ea:	8b 40 04             	mov    0x4(%eax),%eax
 9ed:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9f0:	72 4d                	jb     a3f <malloc+0xa6>
      if(p->s.size == nunits)
 9f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f5:	8b 40 04             	mov    0x4(%eax),%eax
 9f8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9fb:	75 0c                	jne    a09 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a00:	8b 10                	mov    (%eax),%edx
 a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a05:	89 10                	mov    %edx,(%eax)
 a07:	eb 26                	jmp    a2f <malloc+0x96>
      else {
        p->s.size -= nunits;
 a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0c:	8b 40 04             	mov    0x4(%eax),%eax
 a0f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a12:	89 c2                	mov    %eax,%edx
 a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a17:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1d:	8b 40 04             	mov    0x4(%eax),%eax
 a20:	c1 e0 03             	shl    $0x3,%eax
 a23:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a29:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a2c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a32:	a3 28 12 00 00       	mov    %eax,0x1228
      return (void*)(p + 1);
 a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3a:	83 c0 08             	add    $0x8,%eax
 a3d:	eb 38                	jmp    a77 <malloc+0xde>
    }
    if(p == freep)
 a3f:	a1 28 12 00 00       	mov    0x1228,%eax
 a44:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a47:	75 1b                	jne    a64 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a49:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a4c:	89 04 24             	mov    %eax,(%esp)
 a4f:	e8 ed fe ff ff       	call   941 <morecore>
 a54:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a57:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a5b:	75 07                	jne    a64 <malloc+0xcb>
        return 0;
 a5d:	b8 00 00 00 00       	mov    $0x0,%eax
 a62:	eb 13                	jmp    a77 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6d:	8b 00                	mov    (%eax),%eax
 a6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a72:	e9 70 ff ff ff       	jmp    9e7 <malloc+0x4e>
}
 a77:	c9                   	leave  
 a78:	c3                   	ret    
 a79:	66 90                	xchg   %ax,%ax
 a7b:	90                   	nop

00000a7c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 a7c:	55                   	push   %ebp
 a7d:	89 e5                	mov    %esp,%ebp
 a7f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 a82:	8b 55 08             	mov    0x8(%ebp),%edx
 a85:	8b 45 0c             	mov    0xc(%ebp),%eax
 a88:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a8b:	f0 87 02             	lock xchg %eax,(%edx)
 a8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 a91:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 a94:	c9                   	leave  
 a95:	c3                   	ret    

00000a96 <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 a96:	55                   	push   %ebp
 a97:	89 e5                	mov    %esp,%ebp
 a99:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 a9c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 aa3:	e8 f1 fe ff ff       	call   999 <malloc>
 aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aae:	85 c0                	test   %eax,%eax
 ab0:	75 1b                	jne    acd <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 ab2:	c7 44 24 04 64 0d 00 	movl   $0xd64,0x4(%esp)
 ab9:	00 
 aba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ac1:	e8 e6 fb ff ff       	call   6ac <printf>
    return -1;
 ac6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 acb:	eb 43                	jmp    b10 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad0:	25 ff 0f 00 00       	and    $0xfff,%eax
 ad5:	85 c0                	test   %eax,%eax
 ad7:	74 14                	je     aed <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adc:	25 ff 0f 00 00       	and    $0xfff,%eax
 ae1:	89 c2                	mov    %eax,%edx
 ae3:	b8 00 10 00 00       	mov    $0x1000,%eax
 ae8:	29 d0                	sub    %edx,%eax
 aea:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af0:	89 44 24 08          	mov    %eax,0x8(%esp)
 af4:	8b 45 14             	mov    0x14(%ebp),%eax
 af7:	89 44 24 04          	mov    %eax,0x4(%esp)
 afb:	8b 45 10             	mov    0x10(%ebp),%eax
 afe:	89 04 24             	mov    %eax,(%esp)
 b01:	e8 a6 fa ff ff       	call   5ac <clone>
 b06:	8b 55 08             	mov    0x8(%ebp),%edx
 b09:	89 02                	mov    %eax,(%edx)
  return *thread;
 b0b:	8b 45 08             	mov    0x8(%ebp),%eax
 b0e:	8b 00                	mov    (%eax),%eax
}
 b10:	c9                   	leave  
 b11:	c3                   	ret    

00000b12 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 b12:	55                   	push   %ebp
 b13:	89 e5                	mov    %esp,%ebp
 b15:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 b18:	8d 45 f4             	lea    -0xc(%ebp),%eax
 b1b:	89 44 24 04          	mov    %eax,0x4(%esp)
 b1f:	8b 45 08             	mov    0x8(%ebp),%eax
 b22:	89 04 24             	mov    %eax,(%esp)
 b25:	e8 8a fa ff ff       	call   5b4 <join>
 b2a:	85 c0                	test   %eax,%eax
 b2c:	79 07                	jns    b35 <pthread_join+0x23>
    return -1;
 b2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b33:	eb 10                	jmp    b45 <pthread_join+0x33>
  }
  free(stack);
 b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b38:	89 04 24             	mov    %eax,(%esp)
 b3b:	e8 20 fd ff ff       	call   860 <free>
  return 0;
 b40:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b45:	c9                   	leave  
 b46:	c3                   	ret    

00000b47 <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 b47:	55                   	push   %ebp
 b48:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 b4a:	8b 45 08             	mov    0x8(%ebp),%eax
 b4d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 b53:	90                   	nop
}
 b54:	5d                   	pop    %ebp
 b55:	c3                   	ret    

00000b56 <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 b56:	55                   	push   %ebp
 b57:	89 e5                	mov    %esp,%ebp
 b59:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 b5c:	90                   	nop
 b5d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 b64:	00 
 b65:	8b 45 08             	mov    0x8(%ebp),%eax
 b68:	89 04 24             	mov    %eax,(%esp)
 b6b:	e8 0c ff ff ff       	call   a7c <xchg>
 b70:	85 c0                	test   %eax,%eax
 b72:	75 e9                	jne    b5d <pthread_mutex_lock+0x7>
  return;
 b74:	90                   	nop
}
 b75:	c9                   	leave  
 b76:	c3                   	ret    

00000b77 <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 b77:	55                   	push   %ebp
 b78:	89 e5                	mov    %esp,%ebp
 b7a:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 b7d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 b84:	00 
 b85:	8b 45 08             	mov    0x8(%ebp),%eax
 b88:	89 04 24             	mov    %eax,(%esp)
 b8b:	e8 ec fe ff ff       	call   a7c <xchg>
  return;
 b90:	90                   	nop
}
 b91:	c9                   	leave  
 b92:	c3                   	ret    

00000b93 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 b93:	55                   	push   %ebp
 b94:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 b96:	8b 45 08             	mov    0x8(%ebp),%eax
 b99:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 b9f:	8b 45 08             	mov    0x8(%ebp),%eax
 ba2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 ba9:	90                   	nop
}
 baa:	5d                   	pop    %ebp
 bab:	c3                   	ret    

00000bac <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 bac:	55                   	push   %ebp
 bad:	89 e5                	mov    %esp,%ebp
 baf:	53                   	push   %ebx
 bb0:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 bb3:	8b 45 08             	mov    0x8(%ebp),%eax
 bb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
 bbc:	89 04 24             	mov    %eax,(%esp)
 bbf:	e8 b3 ff ff ff       	call   b77 <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 bc4:	eb 09                	jmp    bcf <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bc9:	8b 40 04             	mov    0x4(%eax),%eax
 bcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bd2:	8b 40 04             	mov    0x4(%eax),%eax
 bd5:	85 c0                	test   %eax,%eax
 bd7:	75 ed                	jne    bc6 <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 bd9:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 be0:	e8 b4 fd ff ff       	call   999 <malloc>
 be5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 be8:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bee:	8b 58 04             	mov    0x4(%eax),%ebx
 bf1:	e8 8e f9 ff ff       	call   584 <getpid>
 bf6:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bfb:	8b 40 04             	mov    0x4(%eax),%eax
 bfe:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 c05:	8b 45 0c             	mov    0xc(%ebp),%eax
 c08:	89 04 24             	mov    %eax,(%esp)
 c0b:	e8 46 ff ff ff       	call   b56 <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 c10:	8b 45 0c             	mov    0xc(%ebp),%eax
 c13:	89 04 24             	mov    %eax,(%esp)
 c16:	e8 5c ff ff ff       	call   b77 <pthread_mutex_unlock>
  threadSleep(mutex);
 c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
 c1e:	89 04 24             	mov    %eax,(%esp)
 c21:	e8 96 f9 ff ff       	call   5bc <threadSleep>
  pthread_mutex_lock(mutex);
 c26:	8b 45 0c             	mov    0xc(%ebp),%eax
 c29:	89 04 24             	mov    %eax,(%esp)
 c2c:	e8 25 ff ff ff       	call   b56 <pthread_mutex_lock>
  return;
 c31:	90                   	nop
}
 c32:	83 c4 24             	add    $0x24,%esp
 c35:	5b                   	pop    %ebx
 c36:	5d                   	pop    %ebp
 c37:	c3                   	ret    

00000c38 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 c38:	55                   	push   %ebp
 c39:	89 e5                	mov    %esp,%ebp
 c3b:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 c3e:	8b 45 08             	mov    0x8(%ebp),%eax
 c41:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 c44:	eb 09                	jmp    c4f <pthread_cond_signal+0x17>
    mycond = mycond->next;
 c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c49:	8b 40 04             	mov    0x4(%eax),%eax
 c4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c52:	8b 00                	mov    (%eax),%eax
 c54:	83 f8 ff             	cmp    $0xffffffff,%eax
 c57:	74 ed                	je     c46 <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 c59:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c5d:	74 33                	je     c92 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c62:	8b 00                	mov    (%eax),%eax
 c64:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c6a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 c6d:	8b 45 08             	mov    0x8(%ebp),%eax
 c70:	8b 40 04             	mov    0x4(%eax),%eax
 c73:	8b 50 04             	mov    0x4(%eax),%edx
 c76:	8b 45 08             	mov    0x8(%ebp),%eax
 c79:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 c7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c7f:	89 04 24             	mov    %eax,(%esp)
 c82:	e8 d9 fb ff ff       	call   860 <free>
    threadWake(threadId);
 c87:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c8a:	89 04 24             	mov    %eax,(%esp)
 c8d:	e8 32 f9 ff ff       	call   5c4 <threadWake>
  }
  return;
 c92:	90                   	nop
}
 c93:	c9                   	leave  
 c94:	c3                   	ret    

00000c95 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 c95:	55                   	push   %ebp
 c96:	89 e5                	mov    %esp,%ebp
 c98:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 c9b:	8b 45 08             	mov    0x8(%ebp),%eax
 c9e:	8b 55 10             	mov    0x10(%ebp),%edx
 ca1:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 ca3:	8b 45 08             	mov    0x8(%ebp),%eax
 ca6:	83 c0 04             	add    $0x4,%eax
 ca9:	89 04 24             	mov    %eax,(%esp)
 cac:	e8 e2 fe ff ff       	call   b93 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 cb1:	8b 45 08             	mov    0x8(%ebp),%eax
 cb4:	83 c0 0c             	add    $0xc,%eax
 cb7:	89 04 24             	mov    %eax,(%esp)
 cba:	e8 88 fe ff ff       	call   b47 <pthread_mutex_init>
  return;
 cbf:	90                   	nop
}
 cc0:	c9                   	leave  
 cc1:	c3                   	ret    

00000cc2 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 cc2:	55                   	push   %ebp
 cc3:	89 e5                	mov    %esp,%ebp
 cc5:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 cc8:	8b 45 08             	mov    0x8(%ebp),%eax
 ccb:	8b 00                	mov    (%eax),%eax
 ccd:	8d 50 ff             	lea    -0x1(%eax),%edx
 cd0:	8b 45 08             	mov    0x8(%ebp),%eax
 cd3:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 cd5:	8b 45 08             	mov    0x8(%ebp),%eax
 cd8:	8b 00                	mov    (%eax),%eax
 cda:	85 c0                	test   %eax,%eax
 cdc:	79 18                	jns    cf6 <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 cde:	8b 45 08             	mov    0x8(%ebp),%eax
 ce1:	8d 50 0c             	lea    0xc(%eax),%edx
 ce4:	8b 45 08             	mov    0x8(%ebp),%eax
 ce7:	83 c0 04             	add    $0x4,%eax
 cea:	89 54 24 04          	mov    %edx,0x4(%esp)
 cee:	89 04 24             	mov    %eax,(%esp)
 cf1:	e8 b6 fe ff ff       	call   bac <pthread_cond_wait>
  }
  return;
 cf6:	90                   	nop
}
 cf7:	c9                   	leave  
 cf8:	c3                   	ret    

00000cf9 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 cf9:	55                   	push   %ebp
 cfa:	89 e5                	mov    %esp,%ebp
 cfc:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 cff:	8b 45 08             	mov    0x8(%ebp),%eax
 d02:	8b 00                	mov    (%eax),%eax
 d04:	8d 50 01             	lea    0x1(%eax),%edx
 d07:	8b 45 08             	mov    0x8(%ebp),%eax
 d0a:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 d0c:	8b 45 08             	mov    0x8(%ebp),%eax
 d0f:	83 c0 04             	add    $0x4,%eax
 d12:	89 04 24             	mov    %eax,(%esp)
 d15:	e8 1e ff ff ff       	call   c38 <pthread_cond_signal>
  return;
 d1a:	90                   	nop
}
 d1b:	c9                   	leave  
 d1c:	c3                   	ret    
