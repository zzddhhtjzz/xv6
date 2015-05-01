
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 24             	sub    $0x24,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	8b 45 08             	mov    0x8(%ebp),%eax
   a:	89 04 24             	mov    %eax,(%esp)
   d:	e8 de 03 00 00       	call   3f0 <strlen>
  12:	8b 55 08             	mov    0x8(%ebp),%edx
  15:	01 d0                	add    %edx,%eax
  17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1a:	eb 04                	jmp    20 <fmtname+0x20>
  1c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  23:	3b 45 08             	cmp    0x8(%ebp),%eax
  26:	72 0a                	jb     32 <fmtname+0x32>
  28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2b:	0f b6 00             	movzbl (%eax),%eax
  2e:	3c 2f                	cmp    $0x2f,%al
  30:	75 ea                	jne    1c <fmtname+0x1c>
    ;
  p++;
  32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  39:	89 04 24             	mov    %eax,(%esp)
  3c:	e8 af 03 00 00       	call   3f0 <strlen>
  41:	83 f8 0d             	cmp    $0xd,%eax
  44:	76 05                	jbe    4b <fmtname+0x4b>
    return p;
  46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  49:	eb 5f                	jmp    aa <fmtname+0xaa>
  memmove(buf, p, strlen(p));
  4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 9a 03 00 00       	call   3f0 <strlen>
  56:	89 44 24 08          	mov    %eax,0x8(%esp)
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	89 44 24 04          	mov    %eax,0x4(%esp)
  61:	c7 04 24 90 12 00 00 	movl   $0x1290,(%esp)
  68:	e8 12 05 00 00       	call   57f <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  70:	89 04 24             	mov    %eax,(%esp)
  73:	e8 78 03 00 00       	call   3f0 <strlen>
  78:	ba 0e 00 00 00       	mov    $0xe,%edx
  7d:	89 d3                	mov    %edx,%ebx
  7f:	29 c3                	sub    %eax,%ebx
  81:	8b 45 f4             	mov    -0xc(%ebp),%eax
  84:	89 04 24             	mov    %eax,(%esp)
  87:	e8 64 03 00 00       	call   3f0 <strlen>
  8c:	05 90 12 00 00       	add    $0x1290,%eax
  91:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  95:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  9c:	00 
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 72 03 00 00       	call   417 <memset>
  return buf;
  a5:	b8 90 12 00 00       	mov    $0x1290,%eax
}
  aa:	83 c4 24             	add    $0x24,%esp
  ad:	5b                   	pop    %ebx
  ae:	5d                   	pop    %ebp
  af:	c3                   	ret    

000000b0 <ls>:

void
ls(char *path)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  bc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  c3:	00 
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	89 04 24             	mov    %eax,(%esp)
  ca:	e8 35 05 00 00       	call   604 <open>
  cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d6:	79 20                	jns    f8 <ls+0x48>
    printf(2, "ls: cannot open %s\n", path);
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	89 44 24 08          	mov    %eax,0x8(%esp)
  df:	c7 44 24 04 e0 0d 00 	movl   $0xde0,0x4(%esp)
  e6:	00 
  e7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  ee:	e8 79 06 00 00       	call   76c <printf>
    return;
  f3:	e9 01 02 00 00       	jmp    2f9 <ls+0x249>
  }
  
  if(fstat(fd, &st) < 0){
  f8:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 102:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 105:	89 04 24             	mov    %eax,(%esp)
 108:	e8 0f 05 00 00       	call   61c <fstat>
 10d:	85 c0                	test   %eax,%eax
 10f:	79 2b                	jns    13c <ls+0x8c>
    printf(2, "ls: cannot stat %s\n", path);
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	89 44 24 08          	mov    %eax,0x8(%esp)
 118:	c7 44 24 04 f4 0d 00 	movl   $0xdf4,0x4(%esp)
 11f:	00 
 120:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 127:	e8 40 06 00 00       	call   76c <printf>
    close(fd);
 12c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12f:	89 04 24             	mov    %eax,(%esp)
 132:	e8 b5 04 00 00       	call   5ec <close>
    return;
 137:	e9 bd 01 00 00       	jmp    2f9 <ls+0x249>
  }
  
  switch(st.type){
 13c:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 143:	98                   	cwtl   
 144:	83 f8 01             	cmp    $0x1,%eax
 147:	74 53                	je     19c <ls+0xec>
 149:	83 f8 02             	cmp    $0x2,%eax
 14c:	0f 85 9c 01 00 00    	jne    2ee <ls+0x23e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 158:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15e:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 165:	0f bf d8             	movswl %ax,%ebx
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	89 04 24             	mov    %eax,(%esp)
 16e:	e8 8d fe ff ff       	call   0 <fmtname>
 173:	89 7c 24 14          	mov    %edi,0x14(%esp)
 177:	89 74 24 10          	mov    %esi,0x10(%esp)
 17b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 17f:	89 44 24 08          	mov    %eax,0x8(%esp)
 183:	c7 44 24 04 08 0e 00 	movl   $0xe08,0x4(%esp)
 18a:	00 
 18b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 192:	e8 d5 05 00 00       	call   76c <printf>
    break;
 197:	e9 52 01 00 00       	jmp    2ee <ls+0x23e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	89 04 24             	mov    %eax,(%esp)
 1a2:	e8 49 02 00 00       	call   3f0 <strlen>
 1a7:	83 c0 10             	add    $0x10,%eax
 1aa:	3d 00 02 00 00       	cmp    $0x200,%eax
 1af:	76 19                	jbe    1ca <ls+0x11a>
      printf(1, "ls: path too long\n");
 1b1:	c7 44 24 04 15 0e 00 	movl   $0xe15,0x4(%esp)
 1b8:	00 
 1b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c0:	e8 a7 05 00 00       	call   76c <printf>
      break;
 1c5:	e9 24 01 00 00       	jmp    2ee <ls+0x23e>
    }
    strcpy(buf, path);
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d1:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d7:	89 04 24             	mov    %eax,(%esp)
 1da:	e8 a2 01 00 00       	call   381 <strcpy>
    p = buf+strlen(buf);
 1df:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 03 02 00 00       	call   3f0 <strlen>
 1ed:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1f3:	01 d0                	add    %edx,%eax
 1f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1fb:	8d 50 01             	lea    0x1(%eax),%edx
 1fe:	89 55 e0             	mov    %edx,-0x20(%ebp)
 201:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 204:	e9 be 00 00 00       	jmp    2c7 <ls+0x217>
      if(de.inum == 0)
 209:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 210:	66 85 c0             	test   %ax,%ax
 213:	75 05                	jne    21a <ls+0x16a>
        continue;
 215:	e9 ad 00 00 00       	jmp    2c7 <ls+0x217>
      memmove(p, de.name, DIRSIZ);
 21a:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 221:	00 
 222:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 228:	83 c0 02             	add    $0x2,%eax
 22b:	89 44 24 04          	mov    %eax,0x4(%esp)
 22f:	8b 45 e0             	mov    -0x20(%ebp),%eax
 232:	89 04 24             	mov    %eax,(%esp)
 235:	e8 45 03 00 00       	call   57f <memmove>
      p[DIRSIZ] = 0;
 23a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 23d:	83 c0 0e             	add    $0xe,%eax
 240:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 243:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 253:	89 04 24             	mov    %eax,(%esp)
 256:	e8 89 02 00 00       	call   4e4 <stat>
 25b:	85 c0                	test   %eax,%eax
 25d:	79 20                	jns    27f <ls+0x1cf>
        printf(1, "ls: cannot stat %s\n", buf);
 25f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 265:	89 44 24 08          	mov    %eax,0x8(%esp)
 269:	c7 44 24 04 f4 0d 00 	movl   $0xdf4,0x4(%esp)
 270:	00 
 271:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 278:	e8 ef 04 00 00       	call   76c <printf>
        continue;
 27d:	eb 48                	jmp    2c7 <ls+0x217>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 27f:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 285:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 28b:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 292:	0f bf d8             	movswl %ax,%ebx
 295:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 29b:	89 04 24             	mov    %eax,(%esp)
 29e:	e8 5d fd ff ff       	call   0 <fmtname>
 2a3:	89 7c 24 14          	mov    %edi,0x14(%esp)
 2a7:	89 74 24 10          	mov    %esi,0x10(%esp)
 2ab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 2af:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b3:	c7 44 24 04 08 0e 00 	movl   $0xe08,0x4(%esp)
 2ba:	00 
 2bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2c2:	e8 a5 04 00 00       	call   76c <printf>
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2c7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 2ce:	00 
 2cf:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2dc:	89 04 24             	mov    %eax,(%esp)
 2df:	e8 f8 02 00 00       	call   5dc <read>
 2e4:	83 f8 10             	cmp    $0x10,%eax
 2e7:	0f 84 1c ff ff ff    	je     209 <ls+0x159>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2ed:	90                   	nop
  }
  close(fd);
 2ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2f1:	89 04 24             	mov    %eax,(%esp)
 2f4:	e8 f3 02 00 00       	call   5ec <close>
}
 2f9:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 2ff:	5b                   	pop    %ebx
 300:	5e                   	pop    %esi
 301:	5f                   	pop    %edi
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    

00000304 <main>:

int
main(int argc, char *argv[])
{
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	83 e4 f0             	and    $0xfffffff0,%esp
 30a:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
 30d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 311:	7f 11                	jg     324 <main+0x20>
    ls(".");
 313:	c7 04 24 28 0e 00 00 	movl   $0xe28,(%esp)
 31a:	e8 91 fd ff ff       	call   b0 <ls>
    exit();
 31f:	e8 a0 02 00 00       	call   5c4 <exit>
  }
  for(i=1; i<argc; i++)
 324:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 32b:	00 
 32c:	eb 1f                	jmp    34d <main+0x49>
    ls(argv[i]);
 32e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 339:	8b 45 0c             	mov    0xc(%ebp),%eax
 33c:	01 d0                	add    %edx,%eax
 33e:	8b 00                	mov    (%eax),%eax
 340:	89 04 24             	mov    %eax,(%esp)
 343:	e8 68 fd ff ff       	call   b0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 348:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 34d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 351:	3b 45 08             	cmp    0x8(%ebp),%eax
 354:	7c d8                	jl     32e <main+0x2a>
    ls(argv[i]);
  exit();
 356:	e8 69 02 00 00       	call   5c4 <exit>
 35b:	90                   	nop

0000035c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 35c:	55                   	push   %ebp
 35d:	89 e5                	mov    %esp,%ebp
 35f:	57                   	push   %edi
 360:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 361:	8b 4d 08             	mov    0x8(%ebp),%ecx
 364:	8b 55 10             	mov    0x10(%ebp),%edx
 367:	8b 45 0c             	mov    0xc(%ebp),%eax
 36a:	89 cb                	mov    %ecx,%ebx
 36c:	89 df                	mov    %ebx,%edi
 36e:	89 d1                	mov    %edx,%ecx
 370:	fc                   	cld    
 371:	f3 aa                	rep stos %al,%es:(%edi)
 373:	89 ca                	mov    %ecx,%edx
 375:	89 fb                	mov    %edi,%ebx
 377:	89 5d 08             	mov    %ebx,0x8(%ebp)
 37a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 37d:	5b                   	pop    %ebx
 37e:	5f                   	pop    %edi
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    

00000381 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 381:	55                   	push   %ebp
 382:	89 e5                	mov    %esp,%ebp
 384:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 38d:	90                   	nop
 38e:	8b 45 08             	mov    0x8(%ebp),%eax
 391:	8d 50 01             	lea    0x1(%eax),%edx
 394:	89 55 08             	mov    %edx,0x8(%ebp)
 397:	8b 55 0c             	mov    0xc(%ebp),%edx
 39a:	8d 4a 01             	lea    0x1(%edx),%ecx
 39d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 3a0:	0f b6 12             	movzbl (%edx),%edx
 3a3:	88 10                	mov    %dl,(%eax)
 3a5:	0f b6 00             	movzbl (%eax),%eax
 3a8:	84 c0                	test   %al,%al
 3aa:	75 e2                	jne    38e <strcpy+0xd>
    ;
  return os;
 3ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3af:	c9                   	leave  
 3b0:	c3                   	ret    

000003b1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3b4:	eb 08                	jmp    3be <strcmp+0xd>
    p++, q++;
 3b6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3ba:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3be:	8b 45 08             	mov    0x8(%ebp),%eax
 3c1:	0f b6 00             	movzbl (%eax),%eax
 3c4:	84 c0                	test   %al,%al
 3c6:	74 10                	je     3d8 <strcmp+0x27>
 3c8:	8b 45 08             	mov    0x8(%ebp),%eax
 3cb:	0f b6 10             	movzbl (%eax),%edx
 3ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d1:	0f b6 00             	movzbl (%eax),%eax
 3d4:	38 c2                	cmp    %al,%dl
 3d6:	74 de                	je     3b6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3d8:	8b 45 08             	mov    0x8(%ebp),%eax
 3db:	0f b6 00             	movzbl (%eax),%eax
 3de:	0f b6 d0             	movzbl %al,%edx
 3e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e4:	0f b6 00             	movzbl (%eax),%eax
 3e7:	0f b6 c0             	movzbl %al,%eax
 3ea:	29 c2                	sub    %eax,%edx
 3ec:	89 d0                	mov    %edx,%eax
}
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    

000003f0 <strlen>:

uint
strlen(char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3fd:	eb 04                	jmp    403 <strlen+0x13>
 3ff:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 403:	8b 55 fc             	mov    -0x4(%ebp),%edx
 406:	8b 45 08             	mov    0x8(%ebp),%eax
 409:	01 d0                	add    %edx,%eax
 40b:	0f b6 00             	movzbl (%eax),%eax
 40e:	84 c0                	test   %al,%al
 410:	75 ed                	jne    3ff <strlen+0xf>
    ;
  return n;
 412:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 415:	c9                   	leave  
 416:	c3                   	ret    

00000417 <memset>:

void*
memset(void *dst, int c, uint n)
{
 417:	55                   	push   %ebp
 418:	89 e5                	mov    %esp,%ebp
 41a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 41d:	8b 45 10             	mov    0x10(%ebp),%eax
 420:	89 44 24 08          	mov    %eax,0x8(%esp)
 424:	8b 45 0c             	mov    0xc(%ebp),%eax
 427:	89 44 24 04          	mov    %eax,0x4(%esp)
 42b:	8b 45 08             	mov    0x8(%ebp),%eax
 42e:	89 04 24             	mov    %eax,(%esp)
 431:	e8 26 ff ff ff       	call   35c <stosb>
  return dst;
 436:	8b 45 08             	mov    0x8(%ebp),%eax
}
 439:	c9                   	leave  
 43a:	c3                   	ret    

0000043b <strchr>:

char*
strchr(const char *s, char c)
{
 43b:	55                   	push   %ebp
 43c:	89 e5                	mov    %esp,%ebp
 43e:	83 ec 04             	sub    $0x4,%esp
 441:	8b 45 0c             	mov    0xc(%ebp),%eax
 444:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 447:	eb 14                	jmp    45d <strchr+0x22>
    if(*s == c)
 449:	8b 45 08             	mov    0x8(%ebp),%eax
 44c:	0f b6 00             	movzbl (%eax),%eax
 44f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 452:	75 05                	jne    459 <strchr+0x1e>
      return (char*)s;
 454:	8b 45 08             	mov    0x8(%ebp),%eax
 457:	eb 13                	jmp    46c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 459:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 45d:	8b 45 08             	mov    0x8(%ebp),%eax
 460:	0f b6 00             	movzbl (%eax),%eax
 463:	84 c0                	test   %al,%al
 465:	75 e2                	jne    449 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 467:	b8 00 00 00 00       	mov    $0x0,%eax
}
 46c:	c9                   	leave  
 46d:	c3                   	ret    

0000046e <gets>:

char*
gets(char *buf, int max)
{
 46e:	55                   	push   %ebp
 46f:	89 e5                	mov    %esp,%ebp
 471:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 47b:	eb 4c                	jmp    4c9 <gets+0x5b>
    cc = read(0, &c, 1);
 47d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 484:	00 
 485:	8d 45 ef             	lea    -0x11(%ebp),%eax
 488:	89 44 24 04          	mov    %eax,0x4(%esp)
 48c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 493:	e8 44 01 00 00       	call   5dc <read>
 498:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 49b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49f:	7f 02                	jg     4a3 <gets+0x35>
      break;
 4a1:	eb 31                	jmp    4d4 <gets+0x66>
    buf[i++] = c;
 4a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a6:	8d 50 01             	lea    0x1(%eax),%edx
 4a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4ac:	89 c2                	mov    %eax,%edx
 4ae:	8b 45 08             	mov    0x8(%ebp),%eax
 4b1:	01 c2                	add    %eax,%edx
 4b3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 4b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4bd:	3c 0a                	cmp    $0xa,%al
 4bf:	74 13                	je     4d4 <gets+0x66>
 4c1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4c5:	3c 0d                	cmp    $0xd,%al
 4c7:	74 0b                	je     4d4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4cc:	83 c0 01             	add    $0x1,%eax
 4cf:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4d2:	7c a9                	jl     47d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4d7:	8b 45 08             	mov    0x8(%ebp),%eax
 4da:	01 d0                	add    %edx,%eax
 4dc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4df:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4e2:	c9                   	leave  
 4e3:	c3                   	ret    

000004e4 <stat>:

int
stat(char *n, struct stat *st)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4ea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4f1:	00 
 4f2:	8b 45 08             	mov    0x8(%ebp),%eax
 4f5:	89 04 24             	mov    %eax,(%esp)
 4f8:	e8 07 01 00 00       	call   604 <open>
 4fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 500:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 504:	79 07                	jns    50d <stat+0x29>
    return -1;
 506:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 50b:	eb 23                	jmp    530 <stat+0x4c>
  r = fstat(fd, st);
 50d:	8b 45 0c             	mov    0xc(%ebp),%eax
 510:	89 44 24 04          	mov    %eax,0x4(%esp)
 514:	8b 45 f4             	mov    -0xc(%ebp),%eax
 517:	89 04 24             	mov    %eax,(%esp)
 51a:	e8 fd 00 00 00       	call   61c <fstat>
 51f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 522:	8b 45 f4             	mov    -0xc(%ebp),%eax
 525:	89 04 24             	mov    %eax,(%esp)
 528:	e8 bf 00 00 00       	call   5ec <close>
  return r;
 52d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 530:	c9                   	leave  
 531:	c3                   	ret    

00000532 <atoi>:

int
atoi(const char *s)
{
 532:	55                   	push   %ebp
 533:	89 e5                	mov    %esp,%ebp
 535:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 538:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 53f:	eb 25                	jmp    566 <atoi+0x34>
    n = n*10 + *s++ - '0';
 541:	8b 55 fc             	mov    -0x4(%ebp),%edx
 544:	89 d0                	mov    %edx,%eax
 546:	c1 e0 02             	shl    $0x2,%eax
 549:	01 d0                	add    %edx,%eax
 54b:	01 c0                	add    %eax,%eax
 54d:	89 c1                	mov    %eax,%ecx
 54f:	8b 45 08             	mov    0x8(%ebp),%eax
 552:	8d 50 01             	lea    0x1(%eax),%edx
 555:	89 55 08             	mov    %edx,0x8(%ebp)
 558:	0f b6 00             	movzbl (%eax),%eax
 55b:	0f be c0             	movsbl %al,%eax
 55e:	01 c8                	add    %ecx,%eax
 560:	83 e8 30             	sub    $0x30,%eax
 563:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 566:	8b 45 08             	mov    0x8(%ebp),%eax
 569:	0f b6 00             	movzbl (%eax),%eax
 56c:	3c 2f                	cmp    $0x2f,%al
 56e:	7e 0a                	jle    57a <atoi+0x48>
 570:	8b 45 08             	mov    0x8(%ebp),%eax
 573:	0f b6 00             	movzbl (%eax),%eax
 576:	3c 39                	cmp    $0x39,%al
 578:	7e c7                	jle    541 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 57a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 57d:	c9                   	leave  
 57e:	c3                   	ret    

0000057f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 57f:	55                   	push   %ebp
 580:	89 e5                	mov    %esp,%ebp
 582:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 585:	8b 45 08             	mov    0x8(%ebp),%eax
 588:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 58b:	8b 45 0c             	mov    0xc(%ebp),%eax
 58e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 591:	eb 17                	jmp    5aa <memmove+0x2b>
    *dst++ = *src++;
 593:	8b 45 fc             	mov    -0x4(%ebp),%eax
 596:	8d 50 01             	lea    0x1(%eax),%edx
 599:	89 55 fc             	mov    %edx,-0x4(%ebp)
 59c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 59f:	8d 4a 01             	lea    0x1(%edx),%ecx
 5a2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5a5:	0f b6 12             	movzbl (%edx),%edx
 5a8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5aa:	8b 45 10             	mov    0x10(%ebp),%eax
 5ad:	8d 50 ff             	lea    -0x1(%eax),%edx
 5b0:	89 55 10             	mov    %edx,0x10(%ebp)
 5b3:	85 c0                	test   %eax,%eax
 5b5:	7f dc                	jg     593 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5ba:	c9                   	leave  
 5bb:	c3                   	ret    

000005bc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5bc:	b8 01 00 00 00       	mov    $0x1,%eax
 5c1:	cd 40                	int    $0x40
 5c3:	c3                   	ret    

000005c4 <exit>:
SYSCALL(exit)
 5c4:	b8 02 00 00 00       	mov    $0x2,%eax
 5c9:	cd 40                	int    $0x40
 5cb:	c3                   	ret    

000005cc <wait>:
SYSCALL(wait)
 5cc:	b8 03 00 00 00       	mov    $0x3,%eax
 5d1:	cd 40                	int    $0x40
 5d3:	c3                   	ret    

000005d4 <pipe>:
SYSCALL(pipe)
 5d4:	b8 04 00 00 00       	mov    $0x4,%eax
 5d9:	cd 40                	int    $0x40
 5db:	c3                   	ret    

000005dc <read>:
SYSCALL(read)
 5dc:	b8 05 00 00 00       	mov    $0x5,%eax
 5e1:	cd 40                	int    $0x40
 5e3:	c3                   	ret    

000005e4 <write>:
SYSCALL(write)
 5e4:	b8 10 00 00 00       	mov    $0x10,%eax
 5e9:	cd 40                	int    $0x40
 5eb:	c3                   	ret    

000005ec <close>:
SYSCALL(close)
 5ec:	b8 15 00 00 00       	mov    $0x15,%eax
 5f1:	cd 40                	int    $0x40
 5f3:	c3                   	ret    

000005f4 <kill>:
SYSCALL(kill)
 5f4:	b8 06 00 00 00       	mov    $0x6,%eax
 5f9:	cd 40                	int    $0x40
 5fb:	c3                   	ret    

000005fc <exec>:
SYSCALL(exec)
 5fc:	b8 07 00 00 00       	mov    $0x7,%eax
 601:	cd 40                	int    $0x40
 603:	c3                   	ret    

00000604 <open>:
SYSCALL(open)
 604:	b8 0f 00 00 00       	mov    $0xf,%eax
 609:	cd 40                	int    $0x40
 60b:	c3                   	ret    

0000060c <mknod>:
SYSCALL(mknod)
 60c:	b8 11 00 00 00       	mov    $0x11,%eax
 611:	cd 40                	int    $0x40
 613:	c3                   	ret    

00000614 <unlink>:
SYSCALL(unlink)
 614:	b8 12 00 00 00       	mov    $0x12,%eax
 619:	cd 40                	int    $0x40
 61b:	c3                   	ret    

0000061c <fstat>:
SYSCALL(fstat)
 61c:	b8 08 00 00 00       	mov    $0x8,%eax
 621:	cd 40                	int    $0x40
 623:	c3                   	ret    

00000624 <link>:
SYSCALL(link)
 624:	b8 13 00 00 00       	mov    $0x13,%eax
 629:	cd 40                	int    $0x40
 62b:	c3                   	ret    

0000062c <mkdir>:
SYSCALL(mkdir)
 62c:	b8 14 00 00 00       	mov    $0x14,%eax
 631:	cd 40                	int    $0x40
 633:	c3                   	ret    

00000634 <chdir>:
SYSCALL(chdir)
 634:	b8 09 00 00 00       	mov    $0x9,%eax
 639:	cd 40                	int    $0x40
 63b:	c3                   	ret    

0000063c <dup>:
SYSCALL(dup)
 63c:	b8 0a 00 00 00       	mov    $0xa,%eax
 641:	cd 40                	int    $0x40
 643:	c3                   	ret    

00000644 <getpid>:
SYSCALL(getpid)
 644:	b8 0b 00 00 00       	mov    $0xb,%eax
 649:	cd 40                	int    $0x40
 64b:	c3                   	ret    

0000064c <sbrk>:
SYSCALL(sbrk)
 64c:	b8 0c 00 00 00       	mov    $0xc,%eax
 651:	cd 40                	int    $0x40
 653:	c3                   	ret    

00000654 <sleep>:
SYSCALL(sleep)
 654:	b8 0d 00 00 00       	mov    $0xd,%eax
 659:	cd 40                	int    $0x40
 65b:	c3                   	ret    

0000065c <uptime>:
SYSCALL(uptime)
 65c:	b8 0e 00 00 00       	mov    $0xe,%eax
 661:	cd 40                	int    $0x40
 663:	c3                   	ret    

00000664 <date>:
SYSCALL(date)
 664:	b8 16 00 00 00       	mov    $0x16,%eax
 669:	cd 40                	int    $0x40
 66b:	c3                   	ret    

0000066c <clone>:
SYSCALL(clone)
 66c:	b8 17 00 00 00       	mov    $0x17,%eax
 671:	cd 40                	int    $0x40
 673:	c3                   	ret    

00000674 <join>:
SYSCALL(join)
 674:	b8 18 00 00 00       	mov    $0x18,%eax
 679:	cd 40                	int    $0x40
 67b:	c3                   	ret    

0000067c <threadSleep>:
SYSCALL(threadSleep)
 67c:	b8 19 00 00 00       	mov    $0x19,%eax
 681:	cd 40                	int    $0x40
 683:	c3                   	ret    

00000684 <threadWake>:
SYSCALL(threadWake)
 684:	b8 1a 00 00 00       	mov    $0x1a,%eax
 689:	cd 40                	int    $0x40
 68b:	c3                   	ret    

0000068c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 68c:	55                   	push   %ebp
 68d:	89 e5                	mov    %esp,%ebp
 68f:	83 ec 18             	sub    $0x18,%esp
 692:	8b 45 0c             	mov    0xc(%ebp),%eax
 695:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 698:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 69f:	00 
 6a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a7:	8b 45 08             	mov    0x8(%ebp),%eax
 6aa:	89 04 24             	mov    %eax,(%esp)
 6ad:	e8 32 ff ff ff       	call   5e4 <write>
}
 6b2:	c9                   	leave  
 6b3:	c3                   	ret    

000006b4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	56                   	push   %esi
 6b8:	53                   	push   %ebx
 6b9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6c3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6c7:	74 17                	je     6e0 <printint+0x2c>
 6c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6cd:	79 11                	jns    6e0 <printint+0x2c>
    neg = 1;
 6cf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6d9:	f7 d8                	neg    %eax
 6db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6de:	eb 06                	jmp    6e6 <printint+0x32>
  } else {
    x = xx;
 6e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6f0:	8d 41 01             	lea    0x1(%ecx),%eax
 6f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6fc:	ba 00 00 00 00       	mov    $0x0,%edx
 701:	f7 f3                	div    %ebx
 703:	89 d0                	mov    %edx,%eax
 705:	0f b6 80 7c 12 00 00 	movzbl 0x127c(%eax),%eax
 70c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 710:	8b 75 10             	mov    0x10(%ebp),%esi
 713:	8b 45 ec             	mov    -0x14(%ebp),%eax
 716:	ba 00 00 00 00       	mov    $0x0,%edx
 71b:	f7 f6                	div    %esi
 71d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 720:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 724:	75 c7                	jne    6ed <printint+0x39>
  if(neg)
 726:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72a:	74 10                	je     73c <printint+0x88>
    buf[i++] = '-';
 72c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72f:	8d 50 01             	lea    0x1(%eax),%edx
 732:	89 55 f4             	mov    %edx,-0xc(%ebp)
 735:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 73a:	eb 1f                	jmp    75b <printint+0xa7>
 73c:	eb 1d                	jmp    75b <printint+0xa7>
    putc(fd, buf[i]);
 73e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 741:	8b 45 f4             	mov    -0xc(%ebp),%eax
 744:	01 d0                	add    %edx,%eax
 746:	0f b6 00             	movzbl (%eax),%eax
 749:	0f be c0             	movsbl %al,%eax
 74c:	89 44 24 04          	mov    %eax,0x4(%esp)
 750:	8b 45 08             	mov    0x8(%ebp),%eax
 753:	89 04 24             	mov    %eax,(%esp)
 756:	e8 31 ff ff ff       	call   68c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 75b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 75f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 763:	79 d9                	jns    73e <printint+0x8a>
    putc(fd, buf[i]);
}
 765:	83 c4 30             	add    $0x30,%esp
 768:	5b                   	pop    %ebx
 769:	5e                   	pop    %esi
 76a:	5d                   	pop    %ebp
 76b:	c3                   	ret    

0000076c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 76c:	55                   	push   %ebp
 76d:	89 e5                	mov    %esp,%ebp
 76f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 772:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 779:	8d 45 0c             	lea    0xc(%ebp),%eax
 77c:	83 c0 04             	add    $0x4,%eax
 77f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 782:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 789:	e9 7c 01 00 00       	jmp    90a <printf+0x19e>
    c = fmt[i] & 0xff;
 78e:	8b 55 0c             	mov    0xc(%ebp),%edx
 791:	8b 45 f0             	mov    -0x10(%ebp),%eax
 794:	01 d0                	add    %edx,%eax
 796:	0f b6 00             	movzbl (%eax),%eax
 799:	0f be c0             	movsbl %al,%eax
 79c:	25 ff 00 00 00       	and    $0xff,%eax
 7a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7a8:	75 2c                	jne    7d6 <printf+0x6a>
      if(c == '%'){
 7aa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ae:	75 0c                	jne    7bc <printf+0x50>
        state = '%';
 7b0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7b7:	e9 4a 01 00 00       	jmp    906 <printf+0x19a>
      } else {
        putc(fd, c);
 7bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7bf:	0f be c0             	movsbl %al,%eax
 7c2:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c6:	8b 45 08             	mov    0x8(%ebp),%eax
 7c9:	89 04 24             	mov    %eax,(%esp)
 7cc:	e8 bb fe ff ff       	call   68c <putc>
 7d1:	e9 30 01 00 00       	jmp    906 <printf+0x19a>
      }
    } else if(state == '%'){
 7d6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7da:	0f 85 26 01 00 00    	jne    906 <printf+0x19a>
      if(c == 'd'){
 7e0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7e4:	75 2d                	jne    813 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 7e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7e9:	8b 00                	mov    (%eax),%eax
 7eb:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7f2:	00 
 7f3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7fa:	00 
 7fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ff:	8b 45 08             	mov    0x8(%ebp),%eax
 802:	89 04 24             	mov    %eax,(%esp)
 805:	e8 aa fe ff ff       	call   6b4 <printint>
        ap++;
 80a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 80e:	e9 ec 00 00 00       	jmp    8ff <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 813:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 817:	74 06                	je     81f <printf+0xb3>
 819:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 81d:	75 2d                	jne    84c <printf+0xe0>
        printint(fd, *ap, 16, 0);
 81f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 822:	8b 00                	mov    (%eax),%eax
 824:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 82b:	00 
 82c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 833:	00 
 834:	89 44 24 04          	mov    %eax,0x4(%esp)
 838:	8b 45 08             	mov    0x8(%ebp),%eax
 83b:	89 04 24             	mov    %eax,(%esp)
 83e:	e8 71 fe ff ff       	call   6b4 <printint>
        ap++;
 843:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 847:	e9 b3 00 00 00       	jmp    8ff <printf+0x193>
      } else if(c == 's'){
 84c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 850:	75 45                	jne    897 <printf+0x12b>
        s = (char*)*ap;
 852:	8b 45 e8             	mov    -0x18(%ebp),%eax
 855:	8b 00                	mov    (%eax),%eax
 857:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 85a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 85e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 862:	75 09                	jne    86d <printf+0x101>
          s = "(null)";
 864:	c7 45 f4 2a 0e 00 00 	movl   $0xe2a,-0xc(%ebp)
        while(*s != 0){
 86b:	eb 1e                	jmp    88b <printf+0x11f>
 86d:	eb 1c                	jmp    88b <printf+0x11f>
          putc(fd, *s);
 86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 872:	0f b6 00             	movzbl (%eax),%eax
 875:	0f be c0             	movsbl %al,%eax
 878:	89 44 24 04          	mov    %eax,0x4(%esp)
 87c:	8b 45 08             	mov    0x8(%ebp),%eax
 87f:	89 04 24             	mov    %eax,(%esp)
 882:	e8 05 fe ff ff       	call   68c <putc>
          s++;
 887:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 88b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88e:	0f b6 00             	movzbl (%eax),%eax
 891:	84 c0                	test   %al,%al
 893:	75 da                	jne    86f <printf+0x103>
 895:	eb 68                	jmp    8ff <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 897:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 89b:	75 1d                	jne    8ba <printf+0x14e>
        putc(fd, *ap);
 89d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8a0:	8b 00                	mov    (%eax),%eax
 8a2:	0f be c0             	movsbl %al,%eax
 8a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
 8ac:	89 04 24             	mov    %eax,(%esp)
 8af:	e8 d8 fd ff ff       	call   68c <putc>
        ap++;
 8b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8b8:	eb 45                	jmp    8ff <printf+0x193>
      } else if(c == '%'){
 8ba:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8be:	75 17                	jne    8d7 <printf+0x16b>
        putc(fd, c);
 8c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c3:	0f be c0             	movsbl %al,%eax
 8c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ca:	8b 45 08             	mov    0x8(%ebp),%eax
 8cd:	89 04 24             	mov    %eax,(%esp)
 8d0:	e8 b7 fd ff ff       	call   68c <putc>
 8d5:	eb 28                	jmp    8ff <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d7:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 8de:	00 
 8df:	8b 45 08             	mov    0x8(%ebp),%eax
 8e2:	89 04 24             	mov    %eax,(%esp)
 8e5:	e8 a2 fd ff ff       	call   68c <putc>
        putc(fd, c);
 8ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8ed:	0f be c0             	movsbl %al,%eax
 8f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 8f4:	8b 45 08             	mov    0x8(%ebp),%eax
 8f7:	89 04 24             	mov    %eax,(%esp)
 8fa:	e8 8d fd ff ff       	call   68c <putc>
      }
      state = 0;
 8ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 906:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 90a:	8b 55 0c             	mov    0xc(%ebp),%edx
 90d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 910:	01 d0                	add    %edx,%eax
 912:	0f b6 00             	movzbl (%eax),%eax
 915:	84 c0                	test   %al,%al
 917:	0f 85 71 fe ff ff    	jne    78e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 91d:	c9                   	leave  
 91e:	c3                   	ret    
 91f:	90                   	nop

00000920 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 926:	8b 45 08             	mov    0x8(%ebp),%eax
 929:	83 e8 08             	sub    $0x8,%eax
 92c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92f:	a1 a8 12 00 00       	mov    0x12a8,%eax
 934:	89 45 fc             	mov    %eax,-0x4(%ebp)
 937:	eb 24                	jmp    95d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 939:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93c:	8b 00                	mov    (%eax),%eax
 93e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 941:	77 12                	ja     955 <free+0x35>
 943:	8b 45 f8             	mov    -0x8(%ebp),%eax
 946:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 949:	77 24                	ja     96f <free+0x4f>
 94b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94e:	8b 00                	mov    (%eax),%eax
 950:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 953:	77 1a                	ja     96f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 955:	8b 45 fc             	mov    -0x4(%ebp),%eax
 958:	8b 00                	mov    (%eax),%eax
 95a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 95d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 960:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 963:	76 d4                	jbe    939 <free+0x19>
 965:	8b 45 fc             	mov    -0x4(%ebp),%eax
 968:	8b 00                	mov    (%eax),%eax
 96a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 96d:	76 ca                	jbe    939 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 96f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 972:	8b 40 04             	mov    0x4(%eax),%eax
 975:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 97c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 97f:	01 c2                	add    %eax,%edx
 981:	8b 45 fc             	mov    -0x4(%ebp),%eax
 984:	8b 00                	mov    (%eax),%eax
 986:	39 c2                	cmp    %eax,%edx
 988:	75 24                	jne    9ae <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 98a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 98d:	8b 50 04             	mov    0x4(%eax),%edx
 990:	8b 45 fc             	mov    -0x4(%ebp),%eax
 993:	8b 00                	mov    (%eax),%eax
 995:	8b 40 04             	mov    0x4(%eax),%eax
 998:	01 c2                	add    %eax,%edx
 99a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a3:	8b 00                	mov    (%eax),%eax
 9a5:	8b 10                	mov    (%eax),%edx
 9a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9aa:	89 10                	mov    %edx,(%eax)
 9ac:	eb 0a                	jmp    9b8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b1:	8b 10                	mov    (%eax),%edx
 9b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9b6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bb:	8b 40 04             	mov    0x4(%eax),%eax
 9be:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c8:	01 d0                	add    %edx,%eax
 9ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9cd:	75 20                	jne    9ef <free+0xcf>
    p->s.size += bp->s.size;
 9cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d2:	8b 50 04             	mov    0x4(%eax),%edx
 9d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d8:	8b 40 04             	mov    0x4(%eax),%eax
 9db:	01 c2                	add    %eax,%edx
 9dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9e6:	8b 10                	mov    (%eax),%edx
 9e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9eb:	89 10                	mov    %edx,(%eax)
 9ed:	eb 08                	jmp    9f7 <free+0xd7>
  } else
    p->s.ptr = bp;
 9ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9f5:	89 10                	mov    %edx,(%eax)
  freep = p;
 9f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9fa:	a3 a8 12 00 00       	mov    %eax,0x12a8
}
 9ff:	c9                   	leave  
 a00:	c3                   	ret    

00000a01 <morecore>:

static Header*
morecore(uint nu)
{
 a01:	55                   	push   %ebp
 a02:	89 e5                	mov    %esp,%ebp
 a04:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a07:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a0e:	77 07                	ja     a17 <morecore+0x16>
    nu = 4096;
 a10:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a17:	8b 45 08             	mov    0x8(%ebp),%eax
 a1a:	c1 e0 03             	shl    $0x3,%eax
 a1d:	89 04 24             	mov    %eax,(%esp)
 a20:	e8 27 fc ff ff       	call   64c <sbrk>
 a25:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a28:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a2c:	75 07                	jne    a35 <morecore+0x34>
    return 0;
 a2e:	b8 00 00 00 00       	mov    $0x0,%eax
 a33:	eb 22                	jmp    a57 <morecore+0x56>
  hp = (Header*)p;
 a35:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a3e:	8b 55 08             	mov    0x8(%ebp),%edx
 a41:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a47:	83 c0 08             	add    $0x8,%eax
 a4a:	89 04 24             	mov    %eax,(%esp)
 a4d:	e8 ce fe ff ff       	call   920 <free>
  return freep;
 a52:	a1 a8 12 00 00       	mov    0x12a8,%eax
}
 a57:	c9                   	leave  
 a58:	c3                   	ret    

00000a59 <malloc>:

void*
malloc(uint nbytes)
{
 a59:	55                   	push   %ebp
 a5a:	89 e5                	mov    %esp,%ebp
 a5c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5f:	8b 45 08             	mov    0x8(%ebp),%eax
 a62:	83 c0 07             	add    $0x7,%eax
 a65:	c1 e8 03             	shr    $0x3,%eax
 a68:	83 c0 01             	add    $0x1,%eax
 a6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a6e:	a1 a8 12 00 00       	mov    0x12a8,%eax
 a73:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a76:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a7a:	75 23                	jne    a9f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a7c:	c7 45 f0 a0 12 00 00 	movl   $0x12a0,-0x10(%ebp)
 a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a86:	a3 a8 12 00 00       	mov    %eax,0x12a8
 a8b:	a1 a8 12 00 00       	mov    0x12a8,%eax
 a90:	a3 a0 12 00 00       	mov    %eax,0x12a0
    base.s.size = 0;
 a95:	c7 05 a4 12 00 00 00 	movl   $0x0,0x12a4
 a9c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa2:	8b 00                	mov    (%eax),%eax
 aa4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aaa:	8b 40 04             	mov    0x4(%eax),%eax
 aad:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 ab0:	72 4d                	jb     aff <malloc+0xa6>
      if(p->s.size == nunits)
 ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab5:	8b 40 04             	mov    0x4(%eax),%eax
 ab8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 abb:	75 0c                	jne    ac9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac0:	8b 10                	mov    (%eax),%edx
 ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac5:	89 10                	mov    %edx,(%eax)
 ac7:	eb 26                	jmp    aef <malloc+0x96>
      else {
        p->s.size -= nunits;
 ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acc:	8b 40 04             	mov    0x4(%eax),%eax
 acf:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ad2:	89 c2                	mov    %eax,%edx
 ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
 add:	8b 40 04             	mov    0x4(%eax),%eax
 ae0:	c1 e0 03             	shl    $0x3,%eax
 ae3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae9:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aec:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af2:	a3 a8 12 00 00       	mov    %eax,0x12a8
      return (void*)(p + 1);
 af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afa:	83 c0 08             	add    $0x8,%eax
 afd:	eb 38                	jmp    b37 <malloc+0xde>
    }
    if(p == freep)
 aff:	a1 a8 12 00 00       	mov    0x12a8,%eax
 b04:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b07:	75 1b                	jne    b24 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 b09:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b0c:	89 04 24             	mov    %eax,(%esp)
 b0f:	e8 ed fe ff ff       	call   a01 <morecore>
 b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b17:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b1b:	75 07                	jne    b24 <malloc+0xcb>
        return 0;
 b1d:	b8 00 00 00 00       	mov    $0x0,%eax
 b22:	eb 13                	jmp    b37 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b27:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2d:	8b 00                	mov    (%eax),%eax
 b2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b32:	e9 70 ff ff ff       	jmp    aa7 <malloc+0x4e>
}
 b37:	c9                   	leave  
 b38:	c3                   	ret    
 b39:	66 90                	xchg   %ax,%ax
 b3b:	90                   	nop

00000b3c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 b3c:	55                   	push   %ebp
 b3d:	89 e5                	mov    %esp,%ebp
 b3f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 b42:	8b 55 08             	mov    0x8(%ebp),%edx
 b45:	8b 45 0c             	mov    0xc(%ebp),%eax
 b48:	8b 4d 08             	mov    0x8(%ebp),%ecx
 b4b:	f0 87 02             	lock xchg %eax,(%edx)
 b4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 b51:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 b54:	c9                   	leave  
 b55:	c3                   	ret    

00000b56 <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
 b56:	55                   	push   %ebp
 b57:	89 e5                	mov    %esp,%ebp
 b59:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
 b5c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 b63:	e8 f1 fe ff ff       	call   a59 <malloc>
 b68:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
 b6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6e:	85 c0                	test   %eax,%eax
 b70:	75 1b                	jne    b8d <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
 b72:	c7 44 24 04 34 0e 00 	movl   $0xe34,0x4(%esp)
 b79:	00 
 b7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b81:	e8 e6 fb ff ff       	call   76c <printf>
    return -1;
 b86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b8b:	eb 43                	jmp    bd0 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
 b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b90:	25 ff 0f 00 00       	and    $0xfff,%eax
 b95:	85 c0                	test   %eax,%eax
 b97:	74 14                	je     bad <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
 b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b9c:	25 ff 0f 00 00       	and    $0xfff,%eax
 ba1:	89 c2                	mov    %eax,%edx
 ba3:	b8 00 10 00 00       	mov    $0x1000,%eax
 ba8:	29 d0                	sub    %edx,%eax
 baa:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
 bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bb0:	89 44 24 08          	mov    %eax,0x8(%esp)
 bb4:	8b 45 14             	mov    0x14(%ebp),%eax
 bb7:	89 44 24 04          	mov    %eax,0x4(%esp)
 bbb:	8b 45 10             	mov    0x10(%ebp),%eax
 bbe:	89 04 24             	mov    %eax,(%esp)
 bc1:	e8 a6 fa ff ff       	call   66c <clone>
 bc6:	8b 55 08             	mov    0x8(%ebp),%edx
 bc9:	89 02                	mov    %eax,(%edx)
  return *thread;
 bcb:	8b 45 08             	mov    0x8(%ebp),%eax
 bce:	8b 00                	mov    (%eax),%eax
}
 bd0:	c9                   	leave  
 bd1:	c3                   	ret    

00000bd2 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
 bd2:	55                   	push   %ebp
 bd3:	89 e5                	mov    %esp,%ebp
 bd5:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
 bd8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 bdb:	89 44 24 04          	mov    %eax,0x4(%esp)
 bdf:	8b 45 08             	mov    0x8(%ebp),%eax
 be2:	89 04 24             	mov    %eax,(%esp)
 be5:	e8 8a fa ff ff       	call   674 <join>
 bea:	85 c0                	test   %eax,%eax
 bec:	79 07                	jns    bf5 <pthread_join+0x23>
    return -1;
 bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 bf3:	eb 10                	jmp    c05 <pthread_join+0x33>
  }
  free(stack);
 bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bf8:	89 04 24             	mov    %eax,(%esp)
 bfb:	e8 20 fd ff ff       	call   920 <free>
  return 0;
 c00:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c05:	c9                   	leave  
 c06:	c3                   	ret    

00000c07 <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
 c07:	55                   	push   %ebp
 c08:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
 c0a:	8b 45 08             	mov    0x8(%ebp),%eax
 c0d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
 c13:	90                   	nop
}
 c14:	5d                   	pop    %ebp
 c15:	c3                   	ret    

00000c16 <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
 c16:	55                   	push   %ebp
 c17:	89 e5                	mov    %esp,%ebp
 c19:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
 c1c:	90                   	nop
 c1d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 c24:	00 
 c25:	8b 45 08             	mov    0x8(%ebp),%eax
 c28:	89 04 24             	mov    %eax,(%esp)
 c2b:	e8 0c ff ff ff       	call   b3c <xchg>
 c30:	85 c0                	test   %eax,%eax
 c32:	75 e9                	jne    c1d <pthread_mutex_lock+0x7>
  return;
 c34:	90                   	nop
}
 c35:	c9                   	leave  
 c36:	c3                   	ret    

00000c37 <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
 c37:	55                   	push   %ebp
 c38:	89 e5                	mov    %esp,%ebp
 c3a:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
 c3d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 c44:	00 
 c45:	8b 45 08             	mov    0x8(%ebp),%eax
 c48:	89 04 24             	mov    %eax,(%esp)
 c4b:	e8 ec fe ff ff       	call   b3c <xchg>
  return;
 c50:	90                   	nop
}
 c51:	c9                   	leave  
 c52:	c3                   	ret    

00000c53 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
 c53:	55                   	push   %ebp
 c54:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
 c56:	8b 45 08             	mov    0x8(%ebp),%eax
 c59:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
 c5f:	8b 45 08             	mov    0x8(%ebp),%eax
 c62:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
 c69:	90                   	nop
}
 c6a:	5d                   	pop    %ebp
 c6b:	c3                   	ret    

00000c6c <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
 c6c:	55                   	push   %ebp
 c6d:	89 e5                	mov    %esp,%ebp
 c6f:	53                   	push   %ebx
 c70:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
 c73:	8b 45 08             	mov    0x8(%ebp),%eax
 c76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
 c79:	8b 45 0c             	mov    0xc(%ebp),%eax
 c7c:	89 04 24             	mov    %eax,(%esp)
 c7f:	e8 b3 ff ff ff       	call   c37 <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 c84:	eb 09                	jmp    c8f <pthread_cond_wait+0x23>
    mycond = mycond->next;  
 c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c89:	8b 40 04             	mov    0x4(%eax),%eax
 c8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
 c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c92:	8b 40 04             	mov    0x4(%eax),%eax
 c95:	85 c0                	test   %eax,%eax
 c97:	75 ed                	jne    c86 <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
 c99:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 ca0:	e8 b4 fd ff ff       	call   a59 <malloc>
 ca5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ca8:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
 cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cae:	8b 58 04             	mov    0x4(%eax),%ebx
 cb1:	e8 8e f9 ff ff       	call   644 <getpid>
 cb6:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
 cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cbb:	8b 40 04             	mov    0x4(%eax),%eax
 cbe:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
 cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
 cc8:	89 04 24             	mov    %eax,(%esp)
 ccb:	e8 46 ff ff ff       	call   c16 <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
 cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
 cd3:	89 04 24             	mov    %eax,(%esp)
 cd6:	e8 5c ff ff ff       	call   c37 <pthread_mutex_unlock>
  threadSleep(mutex);
 cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
 cde:	89 04 24             	mov    %eax,(%esp)
 ce1:	e8 96 f9 ff ff       	call   67c <threadSleep>
  pthread_mutex_lock(mutex);
 ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
 ce9:	89 04 24             	mov    %eax,(%esp)
 cec:	e8 25 ff ff ff       	call   c16 <pthread_mutex_lock>
  return;
 cf1:	90                   	nop
}
 cf2:	83 c4 24             	add    $0x24,%esp
 cf5:	5b                   	pop    %ebx
 cf6:	5d                   	pop    %ebp
 cf7:	c3                   	ret    

00000cf8 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
 cf8:	55                   	push   %ebp
 cf9:	89 e5                	mov    %esp,%ebp
 cfb:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
 cfe:	8b 45 08             	mov    0x8(%ebp),%eax
 d01:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
 d04:	eb 09                	jmp    d0f <pthread_cond_signal+0x17>
    mycond = mycond->next;
 d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d09:	8b 40 04             	mov    0x4(%eax),%eax
 d0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
 d0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d12:	8b 00                	mov    (%eax),%eax
 d14:	83 f8 ff             	cmp    $0xffffffff,%eax
 d17:	74 ed                	je     d06 <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
 d19:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d1d:	74 33                	je     d52 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
 d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d22:	8b 00                	mov    (%eax),%eax
 d24:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
 d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d2a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
 d2d:	8b 45 08             	mov    0x8(%ebp),%eax
 d30:	8b 40 04             	mov    0x4(%eax),%eax
 d33:	8b 50 04             	mov    0x4(%eax),%edx
 d36:	8b 45 08             	mov    0x8(%ebp),%eax
 d39:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
 d3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d3f:	89 04 24             	mov    %eax,(%esp)
 d42:	e8 d9 fb ff ff       	call   920 <free>
    threadWake(threadId);
 d47:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d4a:	89 04 24             	mov    %eax,(%esp)
 d4d:	e8 32 f9 ff ff       	call   684 <threadWake>
  }
  return;
 d52:	90                   	nop
}
 d53:	c9                   	leave  
 d54:	c3                   	ret    

00000d55 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
 d55:	55                   	push   %ebp
 d56:	89 e5                	mov    %esp,%ebp
 d58:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
 d5b:	8b 45 08             	mov    0x8(%ebp),%eax
 d5e:	8b 55 10             	mov    0x10(%ebp),%edx
 d61:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
 d63:	8b 45 08             	mov    0x8(%ebp),%eax
 d66:	83 c0 04             	add    $0x4,%eax
 d69:	89 04 24             	mov    %eax,(%esp)
 d6c:	e8 e2 fe ff ff       	call   c53 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
 d71:	8b 45 08             	mov    0x8(%ebp),%eax
 d74:	83 c0 0c             	add    $0xc,%eax
 d77:	89 04 24             	mov    %eax,(%esp)
 d7a:	e8 88 fe ff ff       	call   c07 <pthread_mutex_init>
  return;
 d7f:	90                   	nop
}
 d80:	c9                   	leave  
 d81:	c3                   	ret    

00000d82 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
 d82:	55                   	push   %ebp
 d83:	89 e5                	mov    %esp,%ebp
 d85:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
 d88:	8b 45 08             	mov    0x8(%ebp),%eax
 d8b:	8b 00                	mov    (%eax),%eax
 d8d:	8d 50 ff             	lea    -0x1(%eax),%edx
 d90:	8b 45 08             	mov    0x8(%ebp),%eax
 d93:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
 d95:	8b 45 08             	mov    0x8(%ebp),%eax
 d98:	8b 00                	mov    (%eax),%eax
 d9a:	85 c0                	test   %eax,%eax
 d9c:	79 18                	jns    db6 <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
 d9e:	8b 45 08             	mov    0x8(%ebp),%eax
 da1:	8d 50 0c             	lea    0xc(%eax),%edx
 da4:	8b 45 08             	mov    0x8(%ebp),%eax
 da7:	83 c0 04             	add    $0x4,%eax
 daa:	89 54 24 04          	mov    %edx,0x4(%esp)
 dae:	89 04 24             	mov    %eax,(%esp)
 db1:	e8 b6 fe ff ff       	call   c6c <pthread_cond_wait>
  }
  return;
 db6:	90                   	nop
}
 db7:	c9                   	leave  
 db8:	c3                   	ret    

00000db9 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
 db9:	55                   	push   %ebp
 dba:	89 e5                	mov    %esp,%ebp
 dbc:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
 dbf:	8b 45 08             	mov    0x8(%ebp),%eax
 dc2:	8b 00                	mov    (%eax),%eax
 dc4:	8d 50 01             	lea    0x1(%eax),%edx
 dc7:	8b 45 08             	mov    0x8(%ebp),%eax
 dca:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
 dcc:	8b 45 08             	mov    0x8(%ebp),%eax
 dcf:	83 c0 04             	add    $0x4,%eax
 dd2:	89 04 24             	mov    %eax,(%esp)
 dd5:	e8 1e ff ff ff       	call   cf8 <pthread_cond_signal>
  return;
 dda:	90                   	nop
}
 ddb:	c9                   	leave  
 ddc:	c3                   	ret    
