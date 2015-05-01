
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 53 0f 00 00       	call   f64 <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 ac 17 00 00 	mov    0x17ac(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	c7 04 24 80 17 00 00 	movl   $0x1780,(%esp)
      2b:	e8 27 03 00 00       	call   357 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      30:	8b 45 08             	mov    0x8(%ebp),%eax
      33:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      36:	8b 45 f4             	mov    -0xc(%ebp),%eax
      39:	8b 40 04             	mov    0x4(%eax),%eax
      3c:	85 c0                	test   %eax,%eax
      3e:	75 05                	jne    45 <runcmd+0x45>
      exit();
      40:	e8 1f 0f 00 00       	call   f64 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      45:	8b 45 f4             	mov    -0xc(%ebp),%eax
      48:	8d 50 04             	lea    0x4(%eax),%edx
      4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4e:	8b 40 04             	mov    0x4(%eax),%eax
      51:	89 54 24 04          	mov    %edx,0x4(%esp)
      55:	89 04 24             	mov    %eax,(%esp)
      58:	e8 3f 0f 00 00       	call   f9c <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      60:	8b 40 04             	mov    0x4(%eax),%eax
      63:	89 44 24 08          	mov    %eax,0x8(%esp)
      67:	c7 44 24 04 87 17 00 	movl   $0x1787,0x4(%esp)
      6e:	00 
      6f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      76:	e8 91 10 00 00       	call   110c <printf>
    break;
      7b:	e9 86 01 00 00       	jmp    206 <runcmd+0x206>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	89 04 24             	mov    %eax,(%esp)
      8f:	e8 f8 0e 00 00       	call   f8c <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      94:	8b 45 f0             	mov    -0x10(%ebp),%eax
      97:	8b 50 10             	mov    0x10(%eax),%edx
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	8b 40 08             	mov    0x8(%eax),%eax
      a0:	89 54 24 04          	mov    %edx,0x4(%esp)
      a4:	89 04 24             	mov    %eax,(%esp)
      a7:	e8 f8 0e 00 00       	call   fa4 <open>
      ac:	85 c0                	test   %eax,%eax
      ae:	79 23                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b3:	8b 40 08             	mov    0x8(%eax),%eax
      b6:	89 44 24 08          	mov    %eax,0x8(%esp)
      ba:	c7 44 24 04 97 17 00 	movl   $0x1797,0x4(%esp)
      c1:	00 
      c2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      c9:	e8 3e 10 00 00       	call   110c <printf>
      exit();
      ce:	e8 91 0e 00 00       	call   f64 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	89 04 24             	mov    %eax,(%esp)
      dc:	e8 1f ff ff ff       	call   0 <runcmd>
    break;
      e1:	e9 20 01 00 00       	jmp    206 <runcmd+0x206>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      e6:	8b 45 08             	mov    0x8(%ebp),%eax
      e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      ec:	e8 8c 02 00 00       	call   37d <fork1>
      f1:	85 c0                	test   %eax,%eax
      f3:	75 0e                	jne    103 <runcmd+0x103>
      runcmd(lcmd->left);
      f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
      f8:	8b 40 04             	mov    0x4(%eax),%eax
      fb:	89 04 24             	mov    %eax,(%esp)
      fe:	e8 fd fe ff ff       	call   0 <runcmd>
    wait();
     103:	e8 64 0e 00 00       	call   f6c <wait>
    runcmd(lcmd->right);
     108:	8b 45 ec             	mov    -0x14(%ebp),%eax
     10b:	8b 40 08             	mov    0x8(%eax),%eax
     10e:	89 04 24             	mov    %eax,(%esp)
     111:	e8 ea fe ff ff       	call   0 <runcmd>
    break;
     116:	e9 eb 00 00 00       	jmp    206 <runcmd+0x206>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     11b:	8b 45 08             	mov    0x8(%ebp),%eax
     11e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     121:	8d 45 dc             	lea    -0x24(%ebp),%eax
     124:	89 04 24             	mov    %eax,(%esp)
     127:	e8 48 0e 00 00       	call   f74 <pipe>
     12c:	85 c0                	test   %eax,%eax
     12e:	79 0c                	jns    13c <runcmd+0x13c>
      panic("pipe");
     130:	c7 04 24 a7 17 00 00 	movl   $0x17a7,(%esp)
     137:	e8 1b 02 00 00       	call   357 <panic>
    if(fork1() == 0){
     13c:	e8 3c 02 00 00       	call   37d <fork1>
     141:	85 c0                	test   %eax,%eax
     143:	75 3b                	jne    180 <runcmd+0x180>
      close(1);
     145:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     14c:	e8 3b 0e 00 00       	call   f8c <close>
      dup(p[1]);
     151:	8b 45 e0             	mov    -0x20(%ebp),%eax
     154:	89 04 24             	mov    %eax,(%esp)
     157:	e8 80 0e 00 00       	call   fdc <dup>
      close(p[0]);
     15c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     15f:	89 04 24             	mov    %eax,(%esp)
     162:	e8 25 0e 00 00       	call   f8c <close>
      close(p[1]);
     167:	8b 45 e0             	mov    -0x20(%ebp),%eax
     16a:	89 04 24             	mov    %eax,(%esp)
     16d:	e8 1a 0e 00 00       	call   f8c <close>
      runcmd(pcmd->left);
     172:	8b 45 e8             	mov    -0x18(%ebp),%eax
     175:	8b 40 04             	mov    0x4(%eax),%eax
     178:	89 04 24             	mov    %eax,(%esp)
     17b:	e8 80 fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     180:	e8 f8 01 00 00       	call   37d <fork1>
     185:	85 c0                	test   %eax,%eax
     187:	75 3b                	jne    1c4 <runcmd+0x1c4>
      close(0);
     189:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     190:	e8 f7 0d 00 00       	call   f8c <close>
      dup(p[0]);
     195:	8b 45 dc             	mov    -0x24(%ebp),%eax
     198:	89 04 24             	mov    %eax,(%esp)
     19b:	e8 3c 0e 00 00       	call   fdc <dup>
      close(p[0]);
     1a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1a3:	89 04 24             	mov    %eax,(%esp)
     1a6:	e8 e1 0d 00 00       	call   f8c <close>
      close(p[1]);
     1ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1ae:	89 04 24             	mov    %eax,(%esp)
     1b1:	e8 d6 0d 00 00       	call   f8c <close>
      runcmd(pcmd->right);
     1b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1b9:	8b 40 08             	mov    0x8(%eax),%eax
     1bc:	89 04 24             	mov    %eax,(%esp)
     1bf:	e8 3c fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1c7:	89 04 24             	mov    %eax,(%esp)
     1ca:	e8 bd 0d 00 00       	call   f8c <close>
    close(p[1]);
     1cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1d2:	89 04 24             	mov    %eax,(%esp)
     1d5:	e8 b2 0d 00 00       	call   f8c <close>
    wait();
     1da:	e8 8d 0d 00 00       	call   f6c <wait>
    wait();
     1df:	e8 88 0d 00 00       	call   f6c <wait>
    break;
     1e4:	eb 20                	jmp    206 <runcmd+0x206>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     1e6:	8b 45 08             	mov    0x8(%ebp),%eax
     1e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     1ec:	e8 8c 01 00 00       	call   37d <fork1>
     1f1:	85 c0                	test   %eax,%eax
     1f3:	75 10                	jne    205 <runcmd+0x205>
      runcmd(bcmd->cmd);
     1f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     1f8:	8b 40 04             	mov    0x4(%eax),%eax
     1fb:	89 04 24             	mov    %eax,(%esp)
     1fe:	e8 fd fd ff ff       	call   0 <runcmd>
    break;
     203:	eb 00                	jmp    205 <runcmd+0x205>
     205:	90                   	nop
  }
  exit();
     206:	e8 59 0d 00 00       	call   f64 <exit>

0000020b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     20b:	55                   	push   %ebp
     20c:	89 e5                	mov    %esp,%ebp
     20e:	83 ec 18             	sub    $0x18,%esp
  printf(2, "$ ");
     211:	c7 44 24 04 c4 17 00 	movl   $0x17c4,0x4(%esp)
     218:	00 
     219:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     220:	e8 e7 0e 00 00       	call   110c <printf>
  memset(buf, 0, nbuf);
     225:	8b 45 0c             	mov    0xc(%ebp),%eax
     228:	89 44 24 08          	mov    %eax,0x8(%esp)
     22c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     233:	00 
     234:	8b 45 08             	mov    0x8(%ebp),%eax
     237:	89 04 24             	mov    %eax,(%esp)
     23a:	e8 78 0b 00 00       	call   db7 <memset>
  gets(buf, nbuf);
     23f:	8b 45 0c             	mov    0xc(%ebp),%eax
     242:	89 44 24 04          	mov    %eax,0x4(%esp)
     246:	8b 45 08             	mov    0x8(%ebp),%eax
     249:	89 04 24             	mov    %eax,(%esp)
     24c:	e8 bd 0b 00 00       	call   e0e <gets>
  if(buf[0] == 0) // EOF
     251:	8b 45 08             	mov    0x8(%ebp),%eax
     254:	0f b6 00             	movzbl (%eax),%eax
     257:	84 c0                	test   %al,%al
     259:	75 07                	jne    262 <getcmd+0x57>
    return -1;
     25b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     260:	eb 05                	jmp    267 <getcmd+0x5c>
  return 0;
     262:	b8 00 00 00 00       	mov    $0x0,%eax
}
     267:	c9                   	leave  
     268:	c3                   	ret    

00000269 <main>:

int
main(void)
{
     269:	55                   	push   %ebp
     26a:	89 e5                	mov    %esp,%ebp
     26c:	83 e4 f0             	and    $0xfffffff0,%esp
     26f:	83 ec 20             	sub    $0x20,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     272:	eb 15                	jmp    289 <main+0x20>
    if(fd >= 3){
     274:	83 7c 24 1c 02       	cmpl   $0x2,0x1c(%esp)
     279:	7e 0e                	jle    289 <main+0x20>
      close(fd);
     27b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     27f:	89 04 24             	mov    %eax,(%esp)
     282:	e8 05 0d 00 00       	call   f8c <close>
      break;
     287:	eb 1f                	jmp    2a8 <main+0x3f>
{
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     289:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     290:	00 
     291:	c7 04 24 c7 17 00 00 	movl   $0x17c7,(%esp)
     298:	e8 07 0d 00 00       	call   fa4 <open>
     29d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     2a1:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
     2a6:	79 cc                	jns    274 <main+0xb>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2a8:	e9 89 00 00 00       	jmp    336 <main+0xcd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2ad:	0f b6 05 e0 1e 00 00 	movzbl 0x1ee0,%eax
     2b4:	3c 63                	cmp    $0x63,%al
     2b6:	75 5c                	jne    314 <main+0xab>
     2b8:	0f b6 05 e1 1e 00 00 	movzbl 0x1ee1,%eax
     2bf:	3c 64                	cmp    $0x64,%al
     2c1:	75 51                	jne    314 <main+0xab>
     2c3:	0f b6 05 e2 1e 00 00 	movzbl 0x1ee2,%eax
     2ca:	3c 20                	cmp    $0x20,%al
     2cc:	75 46                	jne    314 <main+0xab>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     2ce:	c7 04 24 e0 1e 00 00 	movl   $0x1ee0,(%esp)
     2d5:	e8 b6 0a 00 00       	call   d90 <strlen>
     2da:	83 e8 01             	sub    $0x1,%eax
     2dd:	c6 80 e0 1e 00 00 00 	movb   $0x0,0x1ee0(%eax)
      if(chdir(buf+3) < 0)
     2e4:	c7 04 24 e3 1e 00 00 	movl   $0x1ee3,(%esp)
     2eb:	e8 e4 0c 00 00       	call   fd4 <chdir>
     2f0:	85 c0                	test   %eax,%eax
     2f2:	79 1e                	jns    312 <main+0xa9>
        printf(2, "cannot cd %s\n", buf+3);
     2f4:	c7 44 24 08 e3 1e 00 	movl   $0x1ee3,0x8(%esp)
     2fb:	00 
     2fc:	c7 44 24 04 cf 17 00 	movl   $0x17cf,0x4(%esp)
     303:	00 
     304:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     30b:	e8 fc 0d 00 00       	call   110c <printf>
      continue;
     310:	eb 24                	jmp    336 <main+0xcd>
     312:	eb 22                	jmp    336 <main+0xcd>
    }
    if(fork1() == 0)
     314:	e8 64 00 00 00       	call   37d <fork1>
     319:	85 c0                	test   %eax,%eax
     31b:	75 14                	jne    331 <main+0xc8>
      runcmd(parsecmd(buf));
     31d:	c7 04 24 e0 1e 00 00 	movl   $0x1ee0,(%esp)
     324:	e8 c9 03 00 00       	call   6f2 <parsecmd>
     329:	89 04 24             	mov    %eax,(%esp)
     32c:	e8 cf fc ff ff       	call   0 <runcmd>
    wait();
     331:	e8 36 0c 00 00       	call   f6c <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     336:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     33d:	00 
     33e:	c7 04 24 e0 1e 00 00 	movl   $0x1ee0,(%esp)
     345:	e8 c1 fe ff ff       	call   20b <getcmd>
     34a:	85 c0                	test   %eax,%eax
     34c:	0f 89 5b ff ff ff    	jns    2ad <main+0x44>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     352:	e8 0d 0c 00 00       	call   f64 <exit>

00000357 <panic>:
}

void
panic(char *s)
{
     357:	55                   	push   %ebp
     358:	89 e5                	mov    %esp,%ebp
     35a:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     35d:	8b 45 08             	mov    0x8(%ebp),%eax
     360:	89 44 24 08          	mov    %eax,0x8(%esp)
     364:	c7 44 24 04 dd 17 00 	movl   $0x17dd,0x4(%esp)
     36b:	00 
     36c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     373:	e8 94 0d 00 00       	call   110c <printf>
  exit();
     378:	e8 e7 0b 00 00       	call   f64 <exit>

0000037d <fork1>:
}

int
fork1(void)
{
     37d:	55                   	push   %ebp
     37e:	89 e5                	mov    %esp,%ebp
     380:	83 ec 28             	sub    $0x28,%esp
  int pid;
  
  pid = fork();
     383:	e8 d4 0b 00 00       	call   f5c <fork>
     388:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     38b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     38f:	75 0c                	jne    39d <fork1+0x20>
    panic("fork");
     391:	c7 04 24 e1 17 00 00 	movl   $0x17e1,(%esp)
     398:	e8 ba ff ff ff       	call   357 <panic>
  return pid;
     39d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3a0:	c9                   	leave  
     3a1:	c3                   	ret    

000003a2 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3a2:	55                   	push   %ebp
     3a3:	89 e5                	mov    %esp,%ebp
     3a5:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a8:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3af:	e8 45 10 00 00       	call   13f9 <malloc>
     3b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3b7:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3be:	00 
     3bf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3c6:	00 
     3c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3ca:	89 04 24             	mov    %eax,(%esp)
     3cd:	e8 e5 09 00 00       	call   db7 <memset>
  cmd->type = EXEC;
     3d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3d5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     3db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3de:	c9                   	leave  
     3df:	c3                   	ret    

000003e0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 28             	sub    $0x28,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e6:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3ed:	e8 07 10 00 00       	call   13f9 <malloc>
     3f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3f5:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     3fc:	00 
     3fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     404:	00 
     405:	8b 45 f4             	mov    -0xc(%ebp),%eax
     408:	89 04 24             	mov    %eax,(%esp)
     40b:	e8 a7 09 00 00       	call   db7 <memset>
  cmd->type = REDIR;
     410:	8b 45 f4             	mov    -0xc(%ebp),%eax
     413:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     419:	8b 45 f4             	mov    -0xc(%ebp),%eax
     41c:	8b 55 08             	mov    0x8(%ebp),%edx
     41f:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     422:	8b 45 f4             	mov    -0xc(%ebp),%eax
     425:	8b 55 0c             	mov    0xc(%ebp),%edx
     428:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     42b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     42e:	8b 55 10             	mov    0x10(%ebp),%edx
     431:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     434:	8b 45 f4             	mov    -0xc(%ebp),%eax
     437:	8b 55 14             	mov    0x14(%ebp),%edx
     43a:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     43d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     440:	8b 55 18             	mov    0x18(%ebp),%edx
     443:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     446:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     449:	c9                   	leave  
     44a:	c3                   	ret    

0000044b <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     44b:	55                   	push   %ebp
     44c:	89 e5                	mov    %esp,%ebp
     44e:	83 ec 28             	sub    $0x28,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     451:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     458:	e8 9c 0f 00 00       	call   13f9 <malloc>
     45d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     460:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     467:	00 
     468:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     46f:	00 
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
     473:	89 04 24             	mov    %eax,(%esp)
     476:	e8 3c 09 00 00       	call   db7 <memset>
  cmd->type = PIPE;
     47b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47e:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     484:	8b 45 f4             	mov    -0xc(%ebp),%eax
     487:	8b 55 08             	mov    0x8(%ebp),%edx
     48a:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     48d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     490:	8b 55 0c             	mov    0xc(%ebp),%edx
     493:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     496:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     499:	c9                   	leave  
     49a:	c3                   	ret    

0000049b <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     49b:	55                   	push   %ebp
     49c:	89 e5                	mov    %esp,%ebp
     49e:	83 ec 28             	sub    $0x28,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a1:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     4a8:	e8 4c 0f 00 00       	call   13f9 <malloc>
     4ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4b0:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     4b7:	00 
     4b8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4bf:	00 
     4c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c3:	89 04 24             	mov    %eax,(%esp)
     4c6:	e8 ec 08 00 00       	call   db7 <memset>
  cmd->type = LIST;
     4cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ce:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d7:	8b 55 08             	mov    0x8(%ebp),%edx
     4da:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e0:	8b 55 0c             	mov    0xc(%ebp),%edx
     4e3:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4e9:	c9                   	leave  
     4ea:	c3                   	ret    

000004eb <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4eb:	55                   	push   %ebp
     4ec:	89 e5                	mov    %esp,%ebp
     4ee:	83 ec 28             	sub    $0x28,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4f1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4f8:	e8 fc 0e 00 00       	call   13f9 <malloc>
     4fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     500:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     507:	00 
     508:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     50f:	00 
     510:	8b 45 f4             	mov    -0xc(%ebp),%eax
     513:	89 04 24             	mov    %eax,(%esp)
     516:	e8 9c 08 00 00       	call   db7 <memset>
  cmd->type = BACK;
     51b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     51e:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     524:	8b 45 f4             	mov    -0xc(%ebp),%eax
     527:	8b 55 08             	mov    0x8(%ebp),%edx
     52a:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     52d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     530:	c9                   	leave  
     531:	c3                   	ret    

00000532 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     532:	55                   	push   %ebp
     533:	89 e5                	mov    %esp,%ebp
     535:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int ret;
  
  s = *ps;
     538:	8b 45 08             	mov    0x8(%ebp),%eax
     53b:	8b 00                	mov    (%eax),%eax
     53d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     540:	eb 04                	jmp    546 <gettoken+0x14>
    s++;
     542:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     546:	8b 45 f4             	mov    -0xc(%ebp),%eax
     549:	3b 45 0c             	cmp    0xc(%ebp),%eax
     54c:	73 1d                	jae    56b <gettoken+0x39>
     54e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     551:	0f b6 00             	movzbl (%eax),%eax
     554:	0f be c0             	movsbl %al,%eax
     557:	89 44 24 04          	mov    %eax,0x4(%esp)
     55b:	c7 04 24 a8 1e 00 00 	movl   $0x1ea8,(%esp)
     562:	e8 74 08 00 00       	call   ddb <strchr>
     567:	85 c0                	test   %eax,%eax
     569:	75 d7                	jne    542 <gettoken+0x10>
    s++;
  if(q)
     56b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     56f:	74 08                	je     579 <gettoken+0x47>
    *q = s;
     571:	8b 45 10             	mov    0x10(%ebp),%eax
     574:	8b 55 f4             	mov    -0xc(%ebp),%edx
     577:	89 10                	mov    %edx,(%eax)
  ret = *s;
     579:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57c:	0f b6 00             	movzbl (%eax),%eax
     57f:	0f be c0             	movsbl %al,%eax
     582:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     585:	8b 45 f4             	mov    -0xc(%ebp),%eax
     588:	0f b6 00             	movzbl (%eax),%eax
     58b:	0f be c0             	movsbl %al,%eax
     58e:	83 f8 29             	cmp    $0x29,%eax
     591:	7f 14                	jg     5a7 <gettoken+0x75>
     593:	83 f8 28             	cmp    $0x28,%eax
     596:	7d 28                	jge    5c0 <gettoken+0x8e>
     598:	85 c0                	test   %eax,%eax
     59a:	0f 84 94 00 00 00    	je     634 <gettoken+0x102>
     5a0:	83 f8 26             	cmp    $0x26,%eax
     5a3:	74 1b                	je     5c0 <gettoken+0x8e>
     5a5:	eb 3c                	jmp    5e3 <gettoken+0xb1>
     5a7:	83 f8 3e             	cmp    $0x3e,%eax
     5aa:	74 1a                	je     5c6 <gettoken+0x94>
     5ac:	83 f8 3e             	cmp    $0x3e,%eax
     5af:	7f 0a                	jg     5bb <gettoken+0x89>
     5b1:	83 e8 3b             	sub    $0x3b,%eax
     5b4:	83 f8 01             	cmp    $0x1,%eax
     5b7:	77 2a                	ja     5e3 <gettoken+0xb1>
     5b9:	eb 05                	jmp    5c0 <gettoken+0x8e>
     5bb:	83 f8 7c             	cmp    $0x7c,%eax
     5be:	75 23                	jne    5e3 <gettoken+0xb1>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5c4:	eb 6f                	jmp    635 <gettoken+0x103>
  case '>':
    s++;
     5c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5cd:	0f b6 00             	movzbl (%eax),%eax
     5d0:	3c 3e                	cmp    $0x3e,%al
     5d2:	75 0d                	jne    5e1 <gettoken+0xaf>
      ret = '+';
     5d4:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5db:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     5df:	eb 54                	jmp    635 <gettoken+0x103>
     5e1:	eb 52                	jmp    635 <gettoken+0x103>
  default:
    ret = 'a';
     5e3:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5ea:	eb 04                	jmp    5f0 <gettoken+0xbe>
      s++;
     5ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     5f6:	73 3a                	jae    632 <gettoken+0x100>
     5f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fb:	0f b6 00             	movzbl (%eax),%eax
     5fe:	0f be c0             	movsbl %al,%eax
     601:	89 44 24 04          	mov    %eax,0x4(%esp)
     605:	c7 04 24 a8 1e 00 00 	movl   $0x1ea8,(%esp)
     60c:	e8 ca 07 00 00       	call   ddb <strchr>
     611:	85 c0                	test   %eax,%eax
     613:	75 1d                	jne    632 <gettoken+0x100>
     615:	8b 45 f4             	mov    -0xc(%ebp),%eax
     618:	0f b6 00             	movzbl (%eax),%eax
     61b:	0f be c0             	movsbl %al,%eax
     61e:	89 44 24 04          	mov    %eax,0x4(%esp)
     622:	c7 04 24 ae 1e 00 00 	movl   $0x1eae,(%esp)
     629:	e8 ad 07 00 00       	call   ddb <strchr>
     62e:	85 c0                	test   %eax,%eax
     630:	74 ba                	je     5ec <gettoken+0xba>
      s++;
    break;
     632:	eb 01                	jmp    635 <gettoken+0x103>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     634:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     635:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     639:	74 0a                	je     645 <gettoken+0x113>
    *eq = s;
     63b:	8b 45 14             	mov    0x14(%ebp),%eax
     63e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     641:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     643:	eb 06                	jmp    64b <gettoken+0x119>
     645:	eb 04                	jmp    64b <gettoken+0x119>
    s++;
     647:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     64b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     651:	73 1d                	jae    670 <gettoken+0x13e>
     653:	8b 45 f4             	mov    -0xc(%ebp),%eax
     656:	0f b6 00             	movzbl (%eax),%eax
     659:	0f be c0             	movsbl %al,%eax
     65c:	89 44 24 04          	mov    %eax,0x4(%esp)
     660:	c7 04 24 a8 1e 00 00 	movl   $0x1ea8,(%esp)
     667:	e8 6f 07 00 00       	call   ddb <strchr>
     66c:	85 c0                	test   %eax,%eax
     66e:	75 d7                	jne    647 <gettoken+0x115>
    s++;
  *ps = s;
     670:	8b 45 08             	mov    0x8(%ebp),%eax
     673:	8b 55 f4             	mov    -0xc(%ebp),%edx
     676:	89 10                	mov    %edx,(%eax)
  return ret;
     678:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     67b:	c9                   	leave  
     67c:	c3                   	ret    

0000067d <peek>:

int
peek(char **ps, char *es, char *toks)
{
     67d:	55                   	push   %ebp
     67e:	89 e5                	mov    %esp,%ebp
     680:	83 ec 28             	sub    $0x28,%esp
  char *s;
  
  s = *ps;
     683:	8b 45 08             	mov    0x8(%ebp),%eax
     686:	8b 00                	mov    (%eax),%eax
     688:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     68b:	eb 04                	jmp    691 <peek+0x14>
    s++;
     68d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     691:	8b 45 f4             	mov    -0xc(%ebp),%eax
     694:	3b 45 0c             	cmp    0xc(%ebp),%eax
     697:	73 1d                	jae    6b6 <peek+0x39>
     699:	8b 45 f4             	mov    -0xc(%ebp),%eax
     69c:	0f b6 00             	movzbl (%eax),%eax
     69f:	0f be c0             	movsbl %al,%eax
     6a2:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a6:	c7 04 24 a8 1e 00 00 	movl   $0x1ea8,(%esp)
     6ad:	e8 29 07 00 00       	call   ddb <strchr>
     6b2:	85 c0                	test   %eax,%eax
     6b4:	75 d7                	jne    68d <peek+0x10>
    s++;
  *ps = s;
     6b6:	8b 45 08             	mov    0x8(%ebp),%eax
     6b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6bc:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c1:	0f b6 00             	movzbl (%eax),%eax
     6c4:	84 c0                	test   %al,%al
     6c6:	74 23                	je     6eb <peek+0x6e>
     6c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6cb:	0f b6 00             	movzbl (%eax),%eax
     6ce:	0f be c0             	movsbl %al,%eax
     6d1:	89 44 24 04          	mov    %eax,0x4(%esp)
     6d5:	8b 45 10             	mov    0x10(%ebp),%eax
     6d8:	89 04 24             	mov    %eax,(%esp)
     6db:	e8 fb 06 00 00       	call   ddb <strchr>
     6e0:	85 c0                	test   %eax,%eax
     6e2:	74 07                	je     6eb <peek+0x6e>
     6e4:	b8 01 00 00 00       	mov    $0x1,%eax
     6e9:	eb 05                	jmp    6f0 <peek+0x73>
     6eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
     6f0:	c9                   	leave  
     6f1:	c3                   	ret    

000006f2 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     6f2:	55                   	push   %ebp
     6f3:	89 e5                	mov    %esp,%ebp
     6f5:	53                   	push   %ebx
     6f6:	83 ec 24             	sub    $0x24,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     6f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     6fc:	8b 45 08             	mov    0x8(%ebp),%eax
     6ff:	89 04 24             	mov    %eax,(%esp)
     702:	e8 89 06 00 00       	call   d90 <strlen>
     707:	01 d8                	add    %ebx,%eax
     709:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     70c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     70f:	89 44 24 04          	mov    %eax,0x4(%esp)
     713:	8d 45 08             	lea    0x8(%ebp),%eax
     716:	89 04 24             	mov    %eax,(%esp)
     719:	e8 60 00 00 00       	call   77e <parseline>
     71e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     721:	c7 44 24 08 e6 17 00 	movl   $0x17e6,0x8(%esp)
     728:	00 
     729:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72c:	89 44 24 04          	mov    %eax,0x4(%esp)
     730:	8d 45 08             	lea    0x8(%ebp),%eax
     733:	89 04 24             	mov    %eax,(%esp)
     736:	e8 42 ff ff ff       	call   67d <peek>
  if(s != es){
     73b:	8b 45 08             	mov    0x8(%ebp),%eax
     73e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     741:	74 27                	je     76a <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     743:	8b 45 08             	mov    0x8(%ebp),%eax
     746:	89 44 24 08          	mov    %eax,0x8(%esp)
     74a:	c7 44 24 04 e7 17 00 	movl   $0x17e7,0x4(%esp)
     751:	00 
     752:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     759:	e8 ae 09 00 00       	call   110c <printf>
    panic("syntax");
     75e:	c7 04 24 f6 17 00 00 	movl   $0x17f6,(%esp)
     765:	e8 ed fb ff ff       	call   357 <panic>
  }
  nulterminate(cmd);
     76a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76d:	89 04 24             	mov    %eax,(%esp)
     770:	e8 a3 04 00 00       	call   c18 <nulterminate>
  return cmd;
     775:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     778:	83 c4 24             	add    $0x24,%esp
     77b:	5b                   	pop    %ebx
     77c:	5d                   	pop    %ebp
     77d:	c3                   	ret    

0000077e <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     77e:	55                   	push   %ebp
     77f:	89 e5                	mov    %esp,%ebp
     781:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     784:	8b 45 0c             	mov    0xc(%ebp),%eax
     787:	89 44 24 04          	mov    %eax,0x4(%esp)
     78b:	8b 45 08             	mov    0x8(%ebp),%eax
     78e:	89 04 24             	mov    %eax,(%esp)
     791:	e8 bc 00 00 00       	call   852 <parsepipe>
     796:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     799:	eb 30                	jmp    7cb <parseline+0x4d>
    gettoken(ps, es, 0, 0);
     79b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     7a2:	00 
     7a3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     7aa:	00 
     7ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     7ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     7b2:	8b 45 08             	mov    0x8(%ebp),%eax
     7b5:	89 04 24             	mov    %eax,(%esp)
     7b8:	e8 75 fd ff ff       	call   532 <gettoken>
    cmd = backcmd(cmd);
     7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c0:	89 04 24             	mov    %eax,(%esp)
     7c3:	e8 23 fd ff ff       	call   4eb <backcmd>
     7c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     7cb:	c7 44 24 08 fd 17 00 	movl   $0x17fd,0x8(%esp)
     7d2:	00 
     7d3:	8b 45 0c             	mov    0xc(%ebp),%eax
     7d6:	89 44 24 04          	mov    %eax,0x4(%esp)
     7da:	8b 45 08             	mov    0x8(%ebp),%eax
     7dd:	89 04 24             	mov    %eax,(%esp)
     7e0:	e8 98 fe ff ff       	call   67d <peek>
     7e5:	85 c0                	test   %eax,%eax
     7e7:	75 b2                	jne    79b <parseline+0x1d>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     7e9:	c7 44 24 08 ff 17 00 	movl   $0x17ff,0x8(%esp)
     7f0:	00 
     7f1:	8b 45 0c             	mov    0xc(%ebp),%eax
     7f4:	89 44 24 04          	mov    %eax,0x4(%esp)
     7f8:	8b 45 08             	mov    0x8(%ebp),%eax
     7fb:	89 04 24             	mov    %eax,(%esp)
     7fe:	e8 7a fe ff ff       	call   67d <peek>
     803:	85 c0                	test   %eax,%eax
     805:	74 46                	je     84d <parseline+0xcf>
    gettoken(ps, es, 0, 0);
     807:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     80e:	00 
     80f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     816:	00 
     817:	8b 45 0c             	mov    0xc(%ebp),%eax
     81a:	89 44 24 04          	mov    %eax,0x4(%esp)
     81e:	8b 45 08             	mov    0x8(%ebp),%eax
     821:	89 04 24             	mov    %eax,(%esp)
     824:	e8 09 fd ff ff       	call   532 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     829:	8b 45 0c             	mov    0xc(%ebp),%eax
     82c:	89 44 24 04          	mov    %eax,0x4(%esp)
     830:	8b 45 08             	mov    0x8(%ebp),%eax
     833:	89 04 24             	mov    %eax,(%esp)
     836:	e8 43 ff ff ff       	call   77e <parseline>
     83b:	89 44 24 04          	mov    %eax,0x4(%esp)
     83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     842:	89 04 24             	mov    %eax,(%esp)
     845:	e8 51 fc ff ff       	call   49b <listcmd>
     84a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     850:	c9                   	leave  
     851:	c3                   	ret    

00000852 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     852:	55                   	push   %ebp
     853:	89 e5                	mov    %esp,%ebp
     855:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     858:	8b 45 0c             	mov    0xc(%ebp),%eax
     85b:	89 44 24 04          	mov    %eax,0x4(%esp)
     85f:	8b 45 08             	mov    0x8(%ebp),%eax
     862:	89 04 24             	mov    %eax,(%esp)
     865:	e8 68 02 00 00       	call   ad2 <parseexec>
     86a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     86d:	c7 44 24 08 01 18 00 	movl   $0x1801,0x8(%esp)
     874:	00 
     875:	8b 45 0c             	mov    0xc(%ebp),%eax
     878:	89 44 24 04          	mov    %eax,0x4(%esp)
     87c:	8b 45 08             	mov    0x8(%ebp),%eax
     87f:	89 04 24             	mov    %eax,(%esp)
     882:	e8 f6 fd ff ff       	call   67d <peek>
     887:	85 c0                	test   %eax,%eax
     889:	74 46                	je     8d1 <parsepipe+0x7f>
    gettoken(ps, es, 0, 0);
     88b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     892:	00 
     893:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     89a:	00 
     89b:	8b 45 0c             	mov    0xc(%ebp),%eax
     89e:	89 44 24 04          	mov    %eax,0x4(%esp)
     8a2:	8b 45 08             	mov    0x8(%ebp),%eax
     8a5:	89 04 24             	mov    %eax,(%esp)
     8a8:	e8 85 fc ff ff       	call   532 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b0:	89 44 24 04          	mov    %eax,0x4(%esp)
     8b4:	8b 45 08             	mov    0x8(%ebp),%eax
     8b7:	89 04 24             	mov    %eax,(%esp)
     8ba:	e8 93 ff ff ff       	call   852 <parsepipe>
     8bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     8c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c6:	89 04 24             	mov    %eax,(%esp)
     8c9:	e8 7d fb ff ff       	call   44b <pipecmd>
     8ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8d4:	c9                   	leave  
     8d5:	c3                   	ret    

000008d6 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8d6:	55                   	push   %ebp
     8d7:	89 e5                	mov    %esp,%ebp
     8d9:	83 ec 38             	sub    $0x38,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8dc:	e9 f6 00 00 00       	jmp    9d7 <parseredirs+0x101>
    tok = gettoken(ps, es, 0, 0);
     8e1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8e8:	00 
     8e9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8f0:	00 
     8f1:	8b 45 10             	mov    0x10(%ebp),%eax
     8f4:	89 44 24 04          	mov    %eax,0x4(%esp)
     8f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fb:	89 04 24             	mov    %eax,(%esp)
     8fe:	e8 2f fc ff ff       	call   532 <gettoken>
     903:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     906:	8d 45 ec             	lea    -0x14(%ebp),%eax
     909:	89 44 24 0c          	mov    %eax,0xc(%esp)
     90d:	8d 45 f0             	lea    -0x10(%ebp),%eax
     910:	89 44 24 08          	mov    %eax,0x8(%esp)
     914:	8b 45 10             	mov    0x10(%ebp),%eax
     917:	89 44 24 04          	mov    %eax,0x4(%esp)
     91b:	8b 45 0c             	mov    0xc(%ebp),%eax
     91e:	89 04 24             	mov    %eax,(%esp)
     921:	e8 0c fc ff ff       	call   532 <gettoken>
     926:	83 f8 61             	cmp    $0x61,%eax
     929:	74 0c                	je     937 <parseredirs+0x61>
      panic("missing file for redirection");
     92b:	c7 04 24 03 18 00 00 	movl   $0x1803,(%esp)
     932:	e8 20 fa ff ff       	call   357 <panic>
    switch(tok){
     937:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93a:	83 f8 3c             	cmp    $0x3c,%eax
     93d:	74 0f                	je     94e <parseredirs+0x78>
     93f:	83 f8 3e             	cmp    $0x3e,%eax
     942:	74 38                	je     97c <parseredirs+0xa6>
     944:	83 f8 2b             	cmp    $0x2b,%eax
     947:	74 61                	je     9aa <parseredirs+0xd4>
     949:	e9 89 00 00 00       	jmp    9d7 <parseredirs+0x101>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     94e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     951:	8b 45 f0             	mov    -0x10(%ebp),%eax
     954:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     95b:	00 
     95c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     963:	00 
     964:	89 54 24 08          	mov    %edx,0x8(%esp)
     968:	89 44 24 04          	mov    %eax,0x4(%esp)
     96c:	8b 45 08             	mov    0x8(%ebp),%eax
     96f:	89 04 24             	mov    %eax,(%esp)
     972:	e8 69 fa ff ff       	call   3e0 <redircmd>
     977:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     97a:	eb 5b                	jmp    9d7 <parseredirs+0x101>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     97c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     97f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     982:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     989:	00 
     98a:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     991:	00 
     992:	89 54 24 08          	mov    %edx,0x8(%esp)
     996:	89 44 24 04          	mov    %eax,0x4(%esp)
     99a:	8b 45 08             	mov    0x8(%ebp),%eax
     99d:	89 04 24             	mov    %eax,(%esp)
     9a0:	e8 3b fa ff ff       	call   3e0 <redircmd>
     9a5:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     9a8:	eb 2d                	jmp    9d7 <parseredirs+0x101>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     9aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
     9ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9b0:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     9b7:	00 
     9b8:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     9bf:	00 
     9c0:	89 54 24 08          	mov    %edx,0x8(%esp)
     9c4:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c8:	8b 45 08             	mov    0x8(%ebp),%eax
     9cb:	89 04 24             	mov    %eax,(%esp)
     9ce:	e8 0d fa ff ff       	call   3e0 <redircmd>
     9d3:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     9d6:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     9d7:	c7 44 24 08 20 18 00 	movl   $0x1820,0x8(%esp)
     9de:	00 
     9df:	8b 45 10             	mov    0x10(%ebp),%eax
     9e2:	89 44 24 04          	mov    %eax,0x4(%esp)
     9e6:	8b 45 0c             	mov    0xc(%ebp),%eax
     9e9:	89 04 24             	mov    %eax,(%esp)
     9ec:	e8 8c fc ff ff       	call   67d <peek>
     9f1:	85 c0                	test   %eax,%eax
     9f3:	0f 85 e8 fe ff ff    	jne    8e1 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     9f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9fc:	c9                   	leave  
     9fd:	c3                   	ret    

000009fe <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     9fe:	55                   	push   %ebp
     9ff:	89 e5                	mov    %esp,%ebp
     a01:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     a04:	c7 44 24 08 23 18 00 	movl   $0x1823,0x8(%esp)
     a0b:	00 
     a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
     a13:	8b 45 08             	mov    0x8(%ebp),%eax
     a16:	89 04 24             	mov    %eax,(%esp)
     a19:	e8 5f fc ff ff       	call   67d <peek>
     a1e:	85 c0                	test   %eax,%eax
     a20:	75 0c                	jne    a2e <parseblock+0x30>
    panic("parseblock");
     a22:	c7 04 24 25 18 00 00 	movl   $0x1825,(%esp)
     a29:	e8 29 f9 ff ff       	call   357 <panic>
  gettoken(ps, es, 0, 0);
     a2e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a35:	00 
     a36:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a3d:	00 
     a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     a41:	89 44 24 04          	mov    %eax,0x4(%esp)
     a45:	8b 45 08             	mov    0x8(%ebp),%eax
     a48:	89 04 24             	mov    %eax,(%esp)
     a4b:	e8 e2 fa ff ff       	call   532 <gettoken>
  cmd = parseline(ps, es);
     a50:	8b 45 0c             	mov    0xc(%ebp),%eax
     a53:	89 44 24 04          	mov    %eax,0x4(%esp)
     a57:	8b 45 08             	mov    0x8(%ebp),%eax
     a5a:	89 04 24             	mov    %eax,(%esp)
     a5d:	e8 1c fd ff ff       	call   77e <parseline>
     a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     a65:	c7 44 24 08 30 18 00 	movl   $0x1830,0x8(%esp)
     a6c:	00 
     a6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     a70:	89 44 24 04          	mov    %eax,0x4(%esp)
     a74:	8b 45 08             	mov    0x8(%ebp),%eax
     a77:	89 04 24             	mov    %eax,(%esp)
     a7a:	e8 fe fb ff ff       	call   67d <peek>
     a7f:	85 c0                	test   %eax,%eax
     a81:	75 0c                	jne    a8f <parseblock+0x91>
    panic("syntax - missing )");
     a83:	c7 04 24 32 18 00 00 	movl   $0x1832,(%esp)
     a8a:	e8 c8 f8 ff ff       	call   357 <panic>
  gettoken(ps, es, 0, 0);
     a8f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a96:	00 
     a97:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a9e:	00 
     a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     aa2:	89 44 24 04          	mov    %eax,0x4(%esp)
     aa6:	8b 45 08             	mov    0x8(%ebp),%eax
     aa9:	89 04 24             	mov    %eax,(%esp)
     aac:	e8 81 fa ff ff       	call   532 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab4:	89 44 24 08          	mov    %eax,0x8(%esp)
     ab8:	8b 45 08             	mov    0x8(%ebp),%eax
     abb:	89 44 24 04          	mov    %eax,0x4(%esp)
     abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac2:	89 04 24             	mov    %eax,(%esp)
     ac5:	e8 0c fe ff ff       	call   8d6 <parseredirs>
     aca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ad0:	c9                   	leave  
     ad1:	c3                   	ret    

00000ad2 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     ad2:	55                   	push   %ebp
     ad3:	89 e5                	mov    %esp,%ebp
     ad5:	83 ec 38             	sub    $0x38,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     ad8:	c7 44 24 08 23 18 00 	movl   $0x1823,0x8(%esp)
     adf:	00 
     ae0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ae3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ae7:	8b 45 08             	mov    0x8(%ebp),%eax
     aea:	89 04 24             	mov    %eax,(%esp)
     aed:	e8 8b fb ff ff       	call   67d <peek>
     af2:	85 c0                	test   %eax,%eax
     af4:	74 17                	je     b0d <parseexec+0x3b>
    return parseblock(ps, es);
     af6:	8b 45 0c             	mov    0xc(%ebp),%eax
     af9:	89 44 24 04          	mov    %eax,0x4(%esp)
     afd:	8b 45 08             	mov    0x8(%ebp),%eax
     b00:	89 04 24             	mov    %eax,(%esp)
     b03:	e8 f6 fe ff ff       	call   9fe <parseblock>
     b08:	e9 09 01 00 00       	jmp    c16 <parseexec+0x144>

  ret = execcmd();
     b0d:	e8 90 f8 ff ff       	call   3a2 <execcmd>
     b12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     b15:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b18:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     b1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     b22:	8b 45 0c             	mov    0xc(%ebp),%eax
     b25:	89 44 24 08          	mov    %eax,0x8(%esp)
     b29:	8b 45 08             	mov    0x8(%ebp),%eax
     b2c:	89 44 24 04          	mov    %eax,0x4(%esp)
     b30:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b33:	89 04 24             	mov    %eax,(%esp)
     b36:	e8 9b fd ff ff       	call   8d6 <parseredirs>
     b3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     b3e:	e9 8f 00 00 00       	jmp    bd2 <parseexec+0x100>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b43:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b46:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b4a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b4d:	89 44 24 08          	mov    %eax,0x8(%esp)
     b51:	8b 45 0c             	mov    0xc(%ebp),%eax
     b54:	89 44 24 04          	mov    %eax,0x4(%esp)
     b58:	8b 45 08             	mov    0x8(%ebp),%eax
     b5b:	89 04 24             	mov    %eax,(%esp)
     b5e:	e8 cf f9 ff ff       	call   532 <gettoken>
     b63:	89 45 e8             	mov    %eax,-0x18(%ebp)
     b66:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     b6a:	75 05                	jne    b71 <parseexec+0x9f>
      break;
     b6c:	e9 83 00 00 00       	jmp    bf4 <parseexec+0x122>
    if(tok != 'a')
     b71:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     b75:	74 0c                	je     b83 <parseexec+0xb1>
      panic("syntax");
     b77:	c7 04 24 f6 17 00 00 	movl   $0x17f6,(%esp)
     b7e:	e8 d4 f7 ff ff       	call   357 <panic>
    cmd->argv[argc] = q;
     b83:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     b86:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b89:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b8c:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     b90:	8b 55 e0             	mov    -0x20(%ebp),%edx
     b93:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b96:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     b99:	83 c1 08             	add    $0x8,%ecx
     b9c:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     ba0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     ba4:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     ba8:	7e 0c                	jle    bb6 <parseexec+0xe4>
      panic("too many args");
     baa:	c7 04 24 45 18 00 00 	movl   $0x1845,(%esp)
     bb1:	e8 a1 f7 ff ff       	call   357 <panic>
    ret = parseredirs(ret, ps, es);
     bb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb9:	89 44 24 08          	mov    %eax,0x8(%esp)
     bbd:	8b 45 08             	mov    0x8(%ebp),%eax
     bc0:	89 44 24 04          	mov    %eax,0x4(%esp)
     bc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc7:	89 04 24             	mov    %eax,(%esp)
     bca:	e8 07 fd ff ff       	call   8d6 <parseredirs>
     bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     bd2:	c7 44 24 08 53 18 00 	movl   $0x1853,0x8(%esp)
     bd9:	00 
     bda:	8b 45 0c             	mov    0xc(%ebp),%eax
     bdd:	89 44 24 04          	mov    %eax,0x4(%esp)
     be1:	8b 45 08             	mov    0x8(%ebp),%eax
     be4:	89 04 24             	mov    %eax,(%esp)
     be7:	e8 91 fa ff ff       	call   67d <peek>
     bec:	85 c0                	test   %eax,%eax
     bee:	0f 84 4f ff ff ff    	je     b43 <parseexec+0x71>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     bf4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bf7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bfa:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     c01:	00 
  cmd->eargv[argc] = 0;
     c02:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c05:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c08:	83 c2 08             	add    $0x8,%edx
     c0b:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     c12:	00 
  return ret;
     c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     c16:	c9                   	leave  
     c17:	c3                   	ret    

00000c18 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c18:	55                   	push   %ebp
     c19:	89 e5                	mov    %esp,%ebp
     c1b:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     c1e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     c22:	75 0a                	jne    c2e <nulterminate+0x16>
    return 0;
     c24:	b8 00 00 00 00       	mov    $0x0,%eax
     c29:	e9 c9 00 00 00       	jmp    cf7 <nulterminate+0xdf>
  
  switch(cmd->type){
     c2e:	8b 45 08             	mov    0x8(%ebp),%eax
     c31:	8b 00                	mov    (%eax),%eax
     c33:	83 f8 05             	cmp    $0x5,%eax
     c36:	0f 87 b8 00 00 00    	ja     cf4 <nulterminate+0xdc>
     c3c:	8b 04 85 58 18 00 00 	mov    0x1858(,%eax,4),%eax
     c43:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     c45:	8b 45 08             	mov    0x8(%ebp),%eax
     c48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     c4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c52:	eb 14                	jmp    c68 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c57:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c5a:	83 c2 08             	add    $0x8,%edx
     c5d:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     c61:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     c64:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c68:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c6e:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     c72:	85 c0                	test   %eax,%eax
     c74:	75 de                	jne    c54 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     c76:	eb 7c                	jmp    cf4 <nulterminate+0xdc>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     c7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c81:	8b 40 04             	mov    0x4(%eax),%eax
     c84:	89 04 24             	mov    %eax,(%esp)
     c87:	e8 8c ff ff ff       	call   c18 <nulterminate>
    *rcmd->efile = 0;
     c8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c8f:	8b 40 0c             	mov    0xc(%eax),%eax
     c92:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c95:	eb 5d                	jmp    cf4 <nulterminate+0xdc>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     c97:	8b 45 08             	mov    0x8(%ebp),%eax
     c9a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     c9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ca0:	8b 40 04             	mov    0x4(%eax),%eax
     ca3:	89 04 24             	mov    %eax,(%esp)
     ca6:	e8 6d ff ff ff       	call   c18 <nulterminate>
    nulterminate(pcmd->right);
     cab:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cae:	8b 40 08             	mov    0x8(%eax),%eax
     cb1:	89 04 24             	mov    %eax,(%esp)
     cb4:	e8 5f ff ff ff       	call   c18 <nulterminate>
    break;
     cb9:	eb 39                	jmp    cf4 <nulterminate+0xdc>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     cbb:	8b 45 08             	mov    0x8(%ebp),%eax
     cbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     cc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cc4:	8b 40 04             	mov    0x4(%eax),%eax
     cc7:	89 04 24             	mov    %eax,(%esp)
     cca:	e8 49 ff ff ff       	call   c18 <nulterminate>
    nulterminate(lcmd->right);
     ccf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cd2:	8b 40 08             	mov    0x8(%eax),%eax
     cd5:	89 04 24             	mov    %eax,(%esp)
     cd8:	e8 3b ff ff ff       	call   c18 <nulterminate>
    break;
     cdd:	eb 15                	jmp    cf4 <nulterminate+0xdc>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     cdf:	8b 45 08             	mov    0x8(%ebp),%eax
     ce2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     ce5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ce8:	8b 40 04             	mov    0x4(%eax),%eax
     ceb:	89 04 24             	mov    %eax,(%esp)
     cee:	e8 25 ff ff ff       	call   c18 <nulterminate>
    break;
     cf3:	90                   	nop
  }
  return cmd;
     cf4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     cf7:	c9                   	leave  
     cf8:	c3                   	ret    
     cf9:	66 90                	xchg   %ax,%ax
     cfb:	90                   	nop

00000cfc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     cfc:	55                   	push   %ebp
     cfd:	89 e5                	mov    %esp,%ebp
     cff:	57                   	push   %edi
     d00:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     d01:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d04:	8b 55 10             	mov    0x10(%ebp),%edx
     d07:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0a:	89 cb                	mov    %ecx,%ebx
     d0c:	89 df                	mov    %ebx,%edi
     d0e:	89 d1                	mov    %edx,%ecx
     d10:	fc                   	cld    
     d11:	f3 aa                	rep stos %al,%es:(%edi)
     d13:	89 ca                	mov    %ecx,%edx
     d15:	89 fb                	mov    %edi,%ebx
     d17:	89 5d 08             	mov    %ebx,0x8(%ebp)
     d1a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     d1d:	5b                   	pop    %ebx
     d1e:	5f                   	pop    %edi
     d1f:	5d                   	pop    %ebp
     d20:	c3                   	ret    

00000d21 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     d21:	55                   	push   %ebp
     d22:	89 e5                	mov    %esp,%ebp
     d24:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     d27:	8b 45 08             	mov    0x8(%ebp),%eax
     d2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     d2d:	90                   	nop
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	8d 50 01             	lea    0x1(%eax),%edx
     d34:	89 55 08             	mov    %edx,0x8(%ebp)
     d37:	8b 55 0c             	mov    0xc(%ebp),%edx
     d3a:	8d 4a 01             	lea    0x1(%edx),%ecx
     d3d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     d40:	0f b6 12             	movzbl (%edx),%edx
     d43:	88 10                	mov    %dl,(%eax)
     d45:	0f b6 00             	movzbl (%eax),%eax
     d48:	84 c0                	test   %al,%al
     d4a:	75 e2                	jne    d2e <strcpy+0xd>
    ;
  return os;
     d4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d4f:	c9                   	leave  
     d50:	c3                   	ret    

00000d51 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d51:	55                   	push   %ebp
     d52:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     d54:	eb 08                	jmp    d5e <strcmp+0xd>
    p++, q++;
     d56:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d5a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     d5e:	8b 45 08             	mov    0x8(%ebp),%eax
     d61:	0f b6 00             	movzbl (%eax),%eax
     d64:	84 c0                	test   %al,%al
     d66:	74 10                	je     d78 <strcmp+0x27>
     d68:	8b 45 08             	mov    0x8(%ebp),%eax
     d6b:	0f b6 10             	movzbl (%eax),%edx
     d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d71:	0f b6 00             	movzbl (%eax),%eax
     d74:	38 c2                	cmp    %al,%dl
     d76:	74 de                	je     d56 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     d78:	8b 45 08             	mov    0x8(%ebp),%eax
     d7b:	0f b6 00             	movzbl (%eax),%eax
     d7e:	0f b6 d0             	movzbl %al,%edx
     d81:	8b 45 0c             	mov    0xc(%ebp),%eax
     d84:	0f b6 00             	movzbl (%eax),%eax
     d87:	0f b6 c0             	movzbl %al,%eax
     d8a:	29 c2                	sub    %eax,%edx
     d8c:	89 d0                	mov    %edx,%eax
}
     d8e:	5d                   	pop    %ebp
     d8f:	c3                   	ret    

00000d90 <strlen>:

uint
strlen(char *s)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d96:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d9d:	eb 04                	jmp    da3 <strlen+0x13>
     d9f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     da3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	01 d0                	add    %edx,%eax
     dab:	0f b6 00             	movzbl (%eax),%eax
     dae:	84 c0                	test   %al,%al
     db0:	75 ed                	jne    d9f <strlen+0xf>
    ;
  return n;
     db2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     db5:	c9                   	leave  
     db6:	c3                   	ret    

00000db7 <memset>:

void*
memset(void *dst, int c, uint n)
{
     db7:	55                   	push   %ebp
     db8:	89 e5                	mov    %esp,%ebp
     dba:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     dbd:	8b 45 10             	mov    0x10(%ebp),%eax
     dc0:	89 44 24 08          	mov    %eax,0x8(%esp)
     dc4:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc7:	89 44 24 04          	mov    %eax,0x4(%esp)
     dcb:	8b 45 08             	mov    0x8(%ebp),%eax
     dce:	89 04 24             	mov    %eax,(%esp)
     dd1:	e8 26 ff ff ff       	call   cfc <stosb>
  return dst;
     dd6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     dd9:	c9                   	leave  
     dda:	c3                   	ret    

00000ddb <strchr>:

char*
strchr(const char *s, char c)
{
     ddb:	55                   	push   %ebp
     ddc:	89 e5                	mov    %esp,%ebp
     dde:	83 ec 04             	sub    $0x4,%esp
     de1:	8b 45 0c             	mov    0xc(%ebp),%eax
     de4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     de7:	eb 14                	jmp    dfd <strchr+0x22>
    if(*s == c)
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	0f b6 00             	movzbl (%eax),%eax
     def:	3a 45 fc             	cmp    -0x4(%ebp),%al
     df2:	75 05                	jne    df9 <strchr+0x1e>
      return (char*)s;
     df4:	8b 45 08             	mov    0x8(%ebp),%eax
     df7:	eb 13                	jmp    e0c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     df9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dfd:	8b 45 08             	mov    0x8(%ebp),%eax
     e00:	0f b6 00             	movzbl (%eax),%eax
     e03:	84 c0                	test   %al,%al
     e05:	75 e2                	jne    de9 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     e07:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e0c:	c9                   	leave  
     e0d:	c3                   	ret    

00000e0e <gets>:

char*
gets(char *buf, int max)
{
     e0e:	55                   	push   %ebp
     e0f:	89 e5                	mov    %esp,%ebp
     e11:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e1b:	eb 4c                	jmp    e69 <gets+0x5b>
    cc = read(0, &c, 1);
     e1d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e24:	00 
     e25:	8d 45 ef             	lea    -0x11(%ebp),%eax
     e28:	89 44 24 04          	mov    %eax,0x4(%esp)
     e2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e33:	e8 44 01 00 00       	call   f7c <read>
     e38:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     e3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e3f:	7f 02                	jg     e43 <gets+0x35>
      break;
     e41:	eb 31                	jmp    e74 <gets+0x66>
    buf[i++] = c;
     e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e46:	8d 50 01             	lea    0x1(%eax),%edx
     e49:	89 55 f4             	mov    %edx,-0xc(%ebp)
     e4c:	89 c2                	mov    %eax,%edx
     e4e:	8b 45 08             	mov    0x8(%ebp),%eax
     e51:	01 c2                	add    %eax,%edx
     e53:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e57:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     e59:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e5d:	3c 0a                	cmp    $0xa,%al
     e5f:	74 13                	je     e74 <gets+0x66>
     e61:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e65:	3c 0d                	cmp    $0xd,%al
     e67:	74 0b                	je     e74 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6c:	83 c0 01             	add    $0x1,%eax
     e6f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e72:	7c a9                	jl     e1d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     e74:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e77:	8b 45 08             	mov    0x8(%ebp),%eax
     e7a:	01 d0                	add    %edx,%eax
     e7c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     e7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e82:	c9                   	leave  
     e83:	c3                   	ret    

00000e84 <stat>:

int
stat(char *n, struct stat *st)
{
     e84:	55                   	push   %ebp
     e85:	89 e5                	mov    %esp,%ebp
     e87:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e8a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e91:	00 
     e92:	8b 45 08             	mov    0x8(%ebp),%eax
     e95:	89 04 24             	mov    %eax,(%esp)
     e98:	e8 07 01 00 00       	call   fa4 <open>
     e9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     ea0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea4:	79 07                	jns    ead <stat+0x29>
    return -1;
     ea6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     eab:	eb 23                	jmp    ed0 <stat+0x4c>
  r = fstat(fd, st);
     ead:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb0:	89 44 24 04          	mov    %eax,0x4(%esp)
     eb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb7:	89 04 24             	mov    %eax,(%esp)
     eba:	e8 fd 00 00 00       	call   fbc <fstat>
     ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec5:	89 04 24             	mov    %eax,(%esp)
     ec8:	e8 bf 00 00 00       	call   f8c <close>
  return r;
     ecd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     ed0:	c9                   	leave  
     ed1:	c3                   	ret    

00000ed2 <atoi>:

int
atoi(const char *s)
{
     ed2:	55                   	push   %ebp
     ed3:	89 e5                	mov    %esp,%ebp
     ed5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     ed8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     edf:	eb 25                	jmp    f06 <atoi+0x34>
    n = n*10 + *s++ - '0';
     ee1:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ee4:	89 d0                	mov    %edx,%eax
     ee6:	c1 e0 02             	shl    $0x2,%eax
     ee9:	01 d0                	add    %edx,%eax
     eeb:	01 c0                	add    %eax,%eax
     eed:	89 c1                	mov    %eax,%ecx
     eef:	8b 45 08             	mov    0x8(%ebp),%eax
     ef2:	8d 50 01             	lea    0x1(%eax),%edx
     ef5:	89 55 08             	mov    %edx,0x8(%ebp)
     ef8:	0f b6 00             	movzbl (%eax),%eax
     efb:	0f be c0             	movsbl %al,%eax
     efe:	01 c8                	add    %ecx,%eax
     f00:	83 e8 30             	sub    $0x30,%eax
     f03:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f06:	8b 45 08             	mov    0x8(%ebp),%eax
     f09:	0f b6 00             	movzbl (%eax),%eax
     f0c:	3c 2f                	cmp    $0x2f,%al
     f0e:	7e 0a                	jle    f1a <atoi+0x48>
     f10:	8b 45 08             	mov    0x8(%ebp),%eax
     f13:	0f b6 00             	movzbl (%eax),%eax
     f16:	3c 39                	cmp    $0x39,%al
     f18:	7e c7                	jle    ee1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     f1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     f1d:	c9                   	leave  
     f1e:	c3                   	ret    

00000f1f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     f1f:	55                   	push   %ebp
     f20:	89 e5                	mov    %esp,%ebp
     f22:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     f25:	8b 45 08             	mov    0x8(%ebp),%eax
     f28:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     f2b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     f31:	eb 17                	jmp    f4a <memmove+0x2b>
    *dst++ = *src++;
     f33:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f36:	8d 50 01             	lea    0x1(%eax),%edx
     f39:	89 55 fc             	mov    %edx,-0x4(%ebp)
     f3c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f3f:	8d 4a 01             	lea    0x1(%edx),%ecx
     f42:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     f45:	0f b6 12             	movzbl (%edx),%edx
     f48:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     f4a:	8b 45 10             	mov    0x10(%ebp),%eax
     f4d:	8d 50 ff             	lea    -0x1(%eax),%edx
     f50:	89 55 10             	mov    %edx,0x10(%ebp)
     f53:	85 c0                	test   %eax,%eax
     f55:	7f dc                	jg     f33 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     f57:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f5a:	c9                   	leave  
     f5b:	c3                   	ret    

00000f5c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     f5c:	b8 01 00 00 00       	mov    $0x1,%eax
     f61:	cd 40                	int    $0x40
     f63:	c3                   	ret    

00000f64 <exit>:
SYSCALL(exit)
     f64:	b8 02 00 00 00       	mov    $0x2,%eax
     f69:	cd 40                	int    $0x40
     f6b:	c3                   	ret    

00000f6c <wait>:
SYSCALL(wait)
     f6c:	b8 03 00 00 00       	mov    $0x3,%eax
     f71:	cd 40                	int    $0x40
     f73:	c3                   	ret    

00000f74 <pipe>:
SYSCALL(pipe)
     f74:	b8 04 00 00 00       	mov    $0x4,%eax
     f79:	cd 40                	int    $0x40
     f7b:	c3                   	ret    

00000f7c <read>:
SYSCALL(read)
     f7c:	b8 05 00 00 00       	mov    $0x5,%eax
     f81:	cd 40                	int    $0x40
     f83:	c3                   	ret    

00000f84 <write>:
SYSCALL(write)
     f84:	b8 10 00 00 00       	mov    $0x10,%eax
     f89:	cd 40                	int    $0x40
     f8b:	c3                   	ret    

00000f8c <close>:
SYSCALL(close)
     f8c:	b8 15 00 00 00       	mov    $0x15,%eax
     f91:	cd 40                	int    $0x40
     f93:	c3                   	ret    

00000f94 <kill>:
SYSCALL(kill)
     f94:	b8 06 00 00 00       	mov    $0x6,%eax
     f99:	cd 40                	int    $0x40
     f9b:	c3                   	ret    

00000f9c <exec>:
SYSCALL(exec)
     f9c:	b8 07 00 00 00       	mov    $0x7,%eax
     fa1:	cd 40                	int    $0x40
     fa3:	c3                   	ret    

00000fa4 <open>:
SYSCALL(open)
     fa4:	b8 0f 00 00 00       	mov    $0xf,%eax
     fa9:	cd 40                	int    $0x40
     fab:	c3                   	ret    

00000fac <mknod>:
SYSCALL(mknod)
     fac:	b8 11 00 00 00       	mov    $0x11,%eax
     fb1:	cd 40                	int    $0x40
     fb3:	c3                   	ret    

00000fb4 <unlink>:
SYSCALL(unlink)
     fb4:	b8 12 00 00 00       	mov    $0x12,%eax
     fb9:	cd 40                	int    $0x40
     fbb:	c3                   	ret    

00000fbc <fstat>:
SYSCALL(fstat)
     fbc:	b8 08 00 00 00       	mov    $0x8,%eax
     fc1:	cd 40                	int    $0x40
     fc3:	c3                   	ret    

00000fc4 <link>:
SYSCALL(link)
     fc4:	b8 13 00 00 00       	mov    $0x13,%eax
     fc9:	cd 40                	int    $0x40
     fcb:	c3                   	ret    

00000fcc <mkdir>:
SYSCALL(mkdir)
     fcc:	b8 14 00 00 00       	mov    $0x14,%eax
     fd1:	cd 40                	int    $0x40
     fd3:	c3                   	ret    

00000fd4 <chdir>:
SYSCALL(chdir)
     fd4:	b8 09 00 00 00       	mov    $0x9,%eax
     fd9:	cd 40                	int    $0x40
     fdb:	c3                   	ret    

00000fdc <dup>:
SYSCALL(dup)
     fdc:	b8 0a 00 00 00       	mov    $0xa,%eax
     fe1:	cd 40                	int    $0x40
     fe3:	c3                   	ret    

00000fe4 <getpid>:
SYSCALL(getpid)
     fe4:	b8 0b 00 00 00       	mov    $0xb,%eax
     fe9:	cd 40                	int    $0x40
     feb:	c3                   	ret    

00000fec <sbrk>:
SYSCALL(sbrk)
     fec:	b8 0c 00 00 00       	mov    $0xc,%eax
     ff1:	cd 40                	int    $0x40
     ff3:	c3                   	ret    

00000ff4 <sleep>:
SYSCALL(sleep)
     ff4:	b8 0d 00 00 00       	mov    $0xd,%eax
     ff9:	cd 40                	int    $0x40
     ffb:	c3                   	ret    

00000ffc <uptime>:
SYSCALL(uptime)
     ffc:	b8 0e 00 00 00       	mov    $0xe,%eax
    1001:	cd 40                	int    $0x40
    1003:	c3                   	ret    

00001004 <date>:
SYSCALL(date)
    1004:	b8 16 00 00 00       	mov    $0x16,%eax
    1009:	cd 40                	int    $0x40
    100b:	c3                   	ret    

0000100c <clone>:
SYSCALL(clone)
    100c:	b8 17 00 00 00       	mov    $0x17,%eax
    1011:	cd 40                	int    $0x40
    1013:	c3                   	ret    

00001014 <join>:
SYSCALL(join)
    1014:	b8 18 00 00 00       	mov    $0x18,%eax
    1019:	cd 40                	int    $0x40
    101b:	c3                   	ret    

0000101c <threadSleep>:
SYSCALL(threadSleep)
    101c:	b8 19 00 00 00       	mov    $0x19,%eax
    1021:	cd 40                	int    $0x40
    1023:	c3                   	ret    

00001024 <threadWake>:
SYSCALL(threadWake)
    1024:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1029:	cd 40                	int    $0x40
    102b:	c3                   	ret    

0000102c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    102c:	55                   	push   %ebp
    102d:	89 e5                	mov    %esp,%ebp
    102f:	83 ec 18             	sub    $0x18,%esp
    1032:	8b 45 0c             	mov    0xc(%ebp),%eax
    1035:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1038:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    103f:	00 
    1040:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1043:	89 44 24 04          	mov    %eax,0x4(%esp)
    1047:	8b 45 08             	mov    0x8(%ebp),%eax
    104a:	89 04 24             	mov    %eax,(%esp)
    104d:	e8 32 ff ff ff       	call   f84 <write>
}
    1052:	c9                   	leave  
    1053:	c3                   	ret    

00001054 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1054:	55                   	push   %ebp
    1055:	89 e5                	mov    %esp,%ebp
    1057:	56                   	push   %esi
    1058:	53                   	push   %ebx
    1059:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    105c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1063:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1067:	74 17                	je     1080 <printint+0x2c>
    1069:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    106d:	79 11                	jns    1080 <printint+0x2c>
    neg = 1;
    106f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1076:	8b 45 0c             	mov    0xc(%ebp),%eax
    1079:	f7 d8                	neg    %eax
    107b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    107e:	eb 06                	jmp    1086 <printint+0x32>
  } else {
    x = xx;
    1080:	8b 45 0c             	mov    0xc(%ebp),%eax
    1083:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1086:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    108d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1090:	8d 41 01             	lea    0x1(%ecx),%eax
    1093:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1096:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1099:	8b 45 ec             	mov    -0x14(%ebp),%eax
    109c:	ba 00 00 00 00       	mov    $0x0,%edx
    10a1:	f7 f3                	div    %ebx
    10a3:	89 d0                	mov    %edx,%eax
    10a5:	0f b6 80 b8 1e 00 00 	movzbl 0x1eb8(%eax),%eax
    10ac:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    10b0:	8b 75 10             	mov    0x10(%ebp),%esi
    10b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10b6:	ba 00 00 00 00       	mov    $0x0,%edx
    10bb:	f7 f6                	div    %esi
    10bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    10c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10c4:	75 c7                	jne    108d <printint+0x39>
  if(neg)
    10c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10ca:	74 10                	je     10dc <printint+0x88>
    buf[i++] = '-';
    10cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10cf:	8d 50 01             	lea    0x1(%eax),%edx
    10d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    10d5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    10da:	eb 1f                	jmp    10fb <printint+0xa7>
    10dc:	eb 1d                	jmp    10fb <printint+0xa7>
    putc(fd, buf[i]);
    10de:	8d 55 dc             	lea    -0x24(%ebp),%edx
    10e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e4:	01 d0                	add    %edx,%eax
    10e6:	0f b6 00             	movzbl (%eax),%eax
    10e9:	0f be c0             	movsbl %al,%eax
    10ec:	89 44 24 04          	mov    %eax,0x4(%esp)
    10f0:	8b 45 08             	mov    0x8(%ebp),%eax
    10f3:	89 04 24             	mov    %eax,(%esp)
    10f6:	e8 31 ff ff ff       	call   102c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    10fb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    10ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1103:	79 d9                	jns    10de <printint+0x8a>
    putc(fd, buf[i]);
}
    1105:	83 c4 30             	add    $0x30,%esp
    1108:	5b                   	pop    %ebx
    1109:	5e                   	pop    %esi
    110a:	5d                   	pop    %ebp
    110b:	c3                   	ret    

0000110c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    110c:	55                   	push   %ebp
    110d:	89 e5                	mov    %esp,%ebp
    110f:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1112:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1119:	8d 45 0c             	lea    0xc(%ebp),%eax
    111c:	83 c0 04             	add    $0x4,%eax
    111f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1122:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1129:	e9 7c 01 00 00       	jmp    12aa <printf+0x19e>
    c = fmt[i] & 0xff;
    112e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1131:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1134:	01 d0                	add    %edx,%eax
    1136:	0f b6 00             	movzbl (%eax),%eax
    1139:	0f be c0             	movsbl %al,%eax
    113c:	25 ff 00 00 00       	and    $0xff,%eax
    1141:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1144:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1148:	75 2c                	jne    1176 <printf+0x6a>
      if(c == '%'){
    114a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    114e:	75 0c                	jne    115c <printf+0x50>
        state = '%';
    1150:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1157:	e9 4a 01 00 00       	jmp    12a6 <printf+0x19a>
      } else {
        putc(fd, c);
    115c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    115f:	0f be c0             	movsbl %al,%eax
    1162:	89 44 24 04          	mov    %eax,0x4(%esp)
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	89 04 24             	mov    %eax,(%esp)
    116c:	e8 bb fe ff ff       	call   102c <putc>
    1171:	e9 30 01 00 00       	jmp    12a6 <printf+0x19a>
      }
    } else if(state == '%'){
    1176:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    117a:	0f 85 26 01 00 00    	jne    12a6 <printf+0x19a>
      if(c == 'd'){
    1180:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1184:	75 2d                	jne    11b3 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    1186:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1189:	8b 00                	mov    (%eax),%eax
    118b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1192:	00 
    1193:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    119a:	00 
    119b:	89 44 24 04          	mov    %eax,0x4(%esp)
    119f:	8b 45 08             	mov    0x8(%ebp),%eax
    11a2:	89 04 24             	mov    %eax,(%esp)
    11a5:	e8 aa fe ff ff       	call   1054 <printint>
        ap++;
    11aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11ae:	e9 ec 00 00 00       	jmp    129f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    11b3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    11b7:	74 06                	je     11bf <printf+0xb3>
    11b9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    11bd:	75 2d                	jne    11ec <printf+0xe0>
        printint(fd, *ap, 16, 0);
    11bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11c2:	8b 00                	mov    (%eax),%eax
    11c4:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    11cb:	00 
    11cc:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    11d3:	00 
    11d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    11d8:	8b 45 08             	mov    0x8(%ebp),%eax
    11db:	89 04 24             	mov    %eax,(%esp)
    11de:	e8 71 fe ff ff       	call   1054 <printint>
        ap++;
    11e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11e7:	e9 b3 00 00 00       	jmp    129f <printf+0x193>
      } else if(c == 's'){
    11ec:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    11f0:	75 45                	jne    1237 <printf+0x12b>
        s = (char*)*ap;
    11f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11f5:	8b 00                	mov    (%eax),%eax
    11f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    11fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    11fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1202:	75 09                	jne    120d <printf+0x101>
          s = "(null)";
    1204:	c7 45 f4 70 18 00 00 	movl   $0x1870,-0xc(%ebp)
        while(*s != 0){
    120b:	eb 1e                	jmp    122b <printf+0x11f>
    120d:	eb 1c                	jmp    122b <printf+0x11f>
          putc(fd, *s);
    120f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1212:	0f b6 00             	movzbl (%eax),%eax
    1215:	0f be c0             	movsbl %al,%eax
    1218:	89 44 24 04          	mov    %eax,0x4(%esp)
    121c:	8b 45 08             	mov    0x8(%ebp),%eax
    121f:	89 04 24             	mov    %eax,(%esp)
    1222:	e8 05 fe ff ff       	call   102c <putc>
          s++;
    1227:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    122b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    122e:	0f b6 00             	movzbl (%eax),%eax
    1231:	84 c0                	test   %al,%al
    1233:	75 da                	jne    120f <printf+0x103>
    1235:	eb 68                	jmp    129f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1237:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    123b:	75 1d                	jne    125a <printf+0x14e>
        putc(fd, *ap);
    123d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1240:	8b 00                	mov    (%eax),%eax
    1242:	0f be c0             	movsbl %al,%eax
    1245:	89 44 24 04          	mov    %eax,0x4(%esp)
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
    124c:	89 04 24             	mov    %eax,(%esp)
    124f:	e8 d8 fd ff ff       	call   102c <putc>
        ap++;
    1254:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1258:	eb 45                	jmp    129f <printf+0x193>
      } else if(c == '%'){
    125a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    125e:	75 17                	jne    1277 <printf+0x16b>
        putc(fd, c);
    1260:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1263:	0f be c0             	movsbl %al,%eax
    1266:	89 44 24 04          	mov    %eax,0x4(%esp)
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	89 04 24             	mov    %eax,(%esp)
    1270:	e8 b7 fd ff ff       	call   102c <putc>
    1275:	eb 28                	jmp    129f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1277:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    127e:	00 
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
    1282:	89 04 24             	mov    %eax,(%esp)
    1285:	e8 a2 fd ff ff       	call   102c <putc>
        putc(fd, c);
    128a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    128d:	0f be c0             	movsbl %al,%eax
    1290:	89 44 24 04          	mov    %eax,0x4(%esp)
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	89 04 24             	mov    %eax,(%esp)
    129a:	e8 8d fd ff ff       	call   102c <putc>
      }
      state = 0;
    129f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    12aa:	8b 55 0c             	mov    0xc(%ebp),%edx
    12ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12b0:	01 d0                	add    %edx,%eax
    12b2:	0f b6 00             	movzbl (%eax),%eax
    12b5:	84 c0                	test   %al,%al
    12b7:	0f 85 71 fe ff ff    	jne    112e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    12bd:	c9                   	leave  
    12be:	c3                   	ret    
    12bf:	90                   	nop

000012c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    12c6:	8b 45 08             	mov    0x8(%ebp),%eax
    12c9:	83 e8 08             	sub    $0x8,%eax
    12cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12cf:	a1 4c 1f 00 00       	mov    0x1f4c,%eax
    12d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12d7:	eb 24                	jmp    12fd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12dc:	8b 00                	mov    (%eax),%eax
    12de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12e1:	77 12                	ja     12f5 <free+0x35>
    12e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12e9:	77 24                	ja     130f <free+0x4f>
    12eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ee:	8b 00                	mov    (%eax),%eax
    12f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12f3:	77 1a                	ja     130f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12f8:	8b 00                	mov    (%eax),%eax
    12fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1300:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1303:	76 d4                	jbe    12d9 <free+0x19>
    1305:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1308:	8b 00                	mov    (%eax),%eax
    130a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    130d:	76 ca                	jbe    12d9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    130f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1312:	8b 40 04             	mov    0x4(%eax),%eax
    1315:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    131c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    131f:	01 c2                	add    %eax,%edx
    1321:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1324:	8b 00                	mov    (%eax),%eax
    1326:	39 c2                	cmp    %eax,%edx
    1328:	75 24                	jne    134e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    132a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    132d:	8b 50 04             	mov    0x4(%eax),%edx
    1330:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1333:	8b 00                	mov    (%eax),%eax
    1335:	8b 40 04             	mov    0x4(%eax),%eax
    1338:	01 c2                	add    %eax,%edx
    133a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    133d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1340:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1343:	8b 00                	mov    (%eax),%eax
    1345:	8b 10                	mov    (%eax),%edx
    1347:	8b 45 f8             	mov    -0x8(%ebp),%eax
    134a:	89 10                	mov    %edx,(%eax)
    134c:	eb 0a                	jmp    1358 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    134e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1351:	8b 10                	mov    (%eax),%edx
    1353:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1356:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1358:	8b 45 fc             	mov    -0x4(%ebp),%eax
    135b:	8b 40 04             	mov    0x4(%eax),%eax
    135e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1365:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1368:	01 d0                	add    %edx,%eax
    136a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    136d:	75 20                	jne    138f <free+0xcf>
    p->s.size += bp->s.size;
    136f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1372:	8b 50 04             	mov    0x4(%eax),%edx
    1375:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1378:	8b 40 04             	mov    0x4(%eax),%eax
    137b:	01 c2                	add    %eax,%edx
    137d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1380:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1383:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1386:	8b 10                	mov    (%eax),%edx
    1388:	8b 45 fc             	mov    -0x4(%ebp),%eax
    138b:	89 10                	mov    %edx,(%eax)
    138d:	eb 08                	jmp    1397 <free+0xd7>
  } else
    p->s.ptr = bp;
    138f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1392:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1395:	89 10                	mov    %edx,(%eax)
  freep = p;
    1397:	8b 45 fc             	mov    -0x4(%ebp),%eax
    139a:	a3 4c 1f 00 00       	mov    %eax,0x1f4c
}
    139f:	c9                   	leave  
    13a0:	c3                   	ret    

000013a1 <morecore>:

static Header*
morecore(uint nu)
{
    13a1:	55                   	push   %ebp
    13a2:	89 e5                	mov    %esp,%ebp
    13a4:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    13a7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    13ae:	77 07                	ja     13b7 <morecore+0x16>
    nu = 4096;
    13b0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    13b7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ba:	c1 e0 03             	shl    $0x3,%eax
    13bd:	89 04 24             	mov    %eax,(%esp)
    13c0:	e8 27 fc ff ff       	call   fec <sbrk>
    13c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    13c8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    13cc:	75 07                	jne    13d5 <morecore+0x34>
    return 0;
    13ce:	b8 00 00 00 00       	mov    $0x0,%eax
    13d3:	eb 22                	jmp    13f7 <morecore+0x56>
  hp = (Header*)p;
    13d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    13db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13de:	8b 55 08             	mov    0x8(%ebp),%edx
    13e1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    13e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e7:	83 c0 08             	add    $0x8,%eax
    13ea:	89 04 24             	mov    %eax,(%esp)
    13ed:	e8 ce fe ff ff       	call   12c0 <free>
  return freep;
    13f2:	a1 4c 1f 00 00       	mov    0x1f4c,%eax
}
    13f7:	c9                   	leave  
    13f8:	c3                   	ret    

000013f9 <malloc>:

void*
malloc(uint nbytes)
{
    13f9:	55                   	push   %ebp
    13fa:	89 e5                	mov    %esp,%ebp
    13fc:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1402:	83 c0 07             	add    $0x7,%eax
    1405:	c1 e8 03             	shr    $0x3,%eax
    1408:	83 c0 01             	add    $0x1,%eax
    140b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    140e:	a1 4c 1f 00 00       	mov    0x1f4c,%eax
    1413:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1416:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    141a:	75 23                	jne    143f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    141c:	c7 45 f0 44 1f 00 00 	movl   $0x1f44,-0x10(%ebp)
    1423:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1426:	a3 4c 1f 00 00       	mov    %eax,0x1f4c
    142b:	a1 4c 1f 00 00       	mov    0x1f4c,%eax
    1430:	a3 44 1f 00 00       	mov    %eax,0x1f44
    base.s.size = 0;
    1435:	c7 05 48 1f 00 00 00 	movl   $0x0,0x1f48
    143c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    143f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1442:	8b 00                	mov    (%eax),%eax
    1444:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1447:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144a:	8b 40 04             	mov    0x4(%eax),%eax
    144d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1450:	72 4d                	jb     149f <malloc+0xa6>
      if(p->s.size == nunits)
    1452:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1455:	8b 40 04             	mov    0x4(%eax),%eax
    1458:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    145b:	75 0c                	jne    1469 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    145d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1460:	8b 10                	mov    (%eax),%edx
    1462:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1465:	89 10                	mov    %edx,(%eax)
    1467:	eb 26                	jmp    148f <malloc+0x96>
      else {
        p->s.size -= nunits;
    1469:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146c:	8b 40 04             	mov    0x4(%eax),%eax
    146f:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1472:	89 c2                	mov    %eax,%edx
    1474:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1477:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    147a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147d:	8b 40 04             	mov    0x4(%eax),%eax
    1480:	c1 e0 03             	shl    $0x3,%eax
    1483:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1486:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1489:	8b 55 ec             	mov    -0x14(%ebp),%edx
    148c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    148f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1492:	a3 4c 1f 00 00       	mov    %eax,0x1f4c
      return (void*)(p + 1);
    1497:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149a:	83 c0 08             	add    $0x8,%eax
    149d:	eb 38                	jmp    14d7 <malloc+0xde>
    }
    if(p == freep)
    149f:	a1 4c 1f 00 00       	mov    0x1f4c,%eax
    14a4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    14a7:	75 1b                	jne    14c4 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    14a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14ac:	89 04 24             	mov    %eax,(%esp)
    14af:	e8 ed fe ff ff       	call   13a1 <morecore>
    14b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14bb:	75 07                	jne    14c4 <malloc+0xcb>
        return 0;
    14bd:	b8 00 00 00 00       	mov    $0x0,%eax
    14c2:	eb 13                	jmp    14d7 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	8b 00                	mov    (%eax),%eax
    14cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    14d2:	e9 70 ff ff ff       	jmp    1447 <malloc+0x4e>
}
    14d7:	c9                   	leave  
    14d8:	c3                   	ret    
    14d9:	66 90                	xchg   %ax,%ax
    14db:	90                   	nop

000014dc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    14dc:	55                   	push   %ebp
    14dd:	89 e5                	mov    %esp,%ebp
    14df:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    14e2:	8b 55 08             	mov    0x8(%ebp),%edx
    14e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    14eb:	f0 87 02             	lock xchg %eax,(%edx)
    14ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    14f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14f4:	c9                   	leave  
    14f5:	c3                   	ret    

000014f6 <pthread_create>:


#define NULL 0
#define PGSIZE (4096)

int pthread_create(mpthread_t *thread, mpthread_attr_t *attr, void(*func)(void*), void*arg){
    14f6:	55                   	push   %ebp
    14f7:	89 e5                	mov    %esp,%ebp
    14f9:	83 ec 28             	sub    $0x28,%esp
  void *stack = malloc((uint)PGSIZE*2);
    14fc:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1503:	e8 f1 fe ff ff       	call   13f9 <malloc>
    1508:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((uint)stack <= 0){
    150b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150e:	85 c0                	test   %eax,%eax
    1510:	75 1b                	jne    152d <pthread_create+0x37>
    printf(1, "Malloc new stack failed in pthread_create\n");
    1512:	c7 44 24 04 78 18 00 	movl   $0x1878,0x4(%esp)
    1519:	00 
    151a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1521:	e8 e6 fb ff ff       	call   110c <printf>
    return -1;
    1526:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    152b:	eb 43                	jmp    1570 <pthread_create+0x7a>
  }
  if((uint)stack % PGSIZE){
    152d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1530:	25 ff 0f 00 00       	and    $0xfff,%eax
    1535:	85 c0                	test   %eax,%eax
    1537:	74 14                	je     154d <pthread_create+0x57>
    stack += 4096 - ((uint)stack % PGSIZE);
    1539:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153c:	25 ff 0f 00 00       	and    $0xfff,%eax
    1541:	89 c2                	mov    %eax,%edx
    1543:	b8 00 10 00 00       	mov    $0x1000,%eax
    1548:	29 d0                	sub    %edx,%eax
    154a:	01 45 f4             	add    %eax,-0xc(%ebp)
  }
  *thread = clone(func, arg, stack);
    154d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1550:	89 44 24 08          	mov    %eax,0x8(%esp)
    1554:	8b 45 14             	mov    0x14(%ebp),%eax
    1557:	89 44 24 04          	mov    %eax,0x4(%esp)
    155b:	8b 45 10             	mov    0x10(%ebp),%eax
    155e:	89 04 24             	mov    %eax,(%esp)
    1561:	e8 a6 fa ff ff       	call   100c <clone>
    1566:	8b 55 08             	mov    0x8(%ebp),%edx
    1569:	89 02                	mov    %eax,(%edx)
  return *thread;
    156b:	8b 45 08             	mov    0x8(%ebp),%eax
    156e:	8b 00                	mov    (%eax),%eax
}
    1570:	c9                   	leave  
    1571:	c3                   	ret    

00001572 <pthread_join>:

int pthread_join(mpthread_t thread, void **retval){
    1572:	55                   	push   %ebp
    1573:	89 e5                	mov    %esp,%ebp
    1575:	83 ec 28             	sub    $0x28,%esp
  void *stack;
  if(join((uint)thread, &stack)<0){
    1578:	8d 45 f4             	lea    -0xc(%ebp),%eax
    157b:	89 44 24 04          	mov    %eax,0x4(%esp)
    157f:	8b 45 08             	mov    0x8(%ebp),%eax
    1582:	89 04 24             	mov    %eax,(%esp)
    1585:	e8 8a fa ff ff       	call   1014 <join>
    158a:	85 c0                	test   %eax,%eax
    158c:	79 07                	jns    1595 <pthread_join+0x23>
    return -1;
    158e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1593:	eb 10                	jmp    15a5 <pthread_join+0x33>
  }
  free(stack);
    1595:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1598:	89 04 24             	mov    %eax,(%esp)
    159b:	e8 20 fd ff ff       	call   12c0 <free>
  return 0;
    15a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    15a5:	c9                   	leave  
    15a6:	c3                   	ret    

000015a7 <pthread_mutex_init>:

void pthread_mutex_init(mpthread_mutex_t *mutex){
    15a7:	55                   	push   %ebp
    15a8:	89 e5                	mov    %esp,%ebp
  *mutex = 0;
    15aa:	8b 45 08             	mov    0x8(%ebp),%eax
    15ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return;
    15b3:	90                   	nop
}
    15b4:	5d                   	pop    %ebp
    15b5:	c3                   	ret    

000015b6 <pthread_mutex_lock>:

void pthread_mutex_lock(mpthread_mutex_t *mutex){
    15b6:	55                   	push   %ebp
    15b7:	89 e5                	mov    %esp,%ebp
    15b9:	83 ec 08             	sub    $0x8,%esp
  while(xchg(mutex, 1) != 0);
    15bc:	90                   	nop
    15bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    15c4:	00 
    15c5:	8b 45 08             	mov    0x8(%ebp),%eax
    15c8:	89 04 24             	mov    %eax,(%esp)
    15cb:	e8 0c ff ff ff       	call   14dc <xchg>
    15d0:	85 c0                	test   %eax,%eax
    15d2:	75 e9                	jne    15bd <pthread_mutex_lock+0x7>
  return;
    15d4:	90                   	nop
}
    15d5:	c9                   	leave  
    15d6:	c3                   	ret    

000015d7 <pthread_mutex_unlock>:

void pthread_mutex_unlock(mpthread_mutex_t *mutex){
    15d7:	55                   	push   %ebp
    15d8:	89 e5                	mov    %esp,%ebp
    15da:	83 ec 08             	sub    $0x8,%esp
  xchg(mutex, 0);
    15dd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    15e4:	00 
    15e5:	8b 45 08             	mov    0x8(%ebp),%eax
    15e8:	89 04 24             	mov    %eax,(%esp)
    15eb:	e8 ec fe ff ff       	call   14dc <xchg>
  return;
    15f0:	90                   	nop
}
    15f1:	c9                   	leave  
    15f2:	c3                   	ret    

000015f3 <pthread_cond_init>:

void pthread_cond_init(mpthread_cond_t *cond){
    15f3:	55                   	push   %ebp
    15f4:	89 e5                	mov    %esp,%ebp
  cond->threadId = -1;
    15f6:	8b 45 08             	mov    0x8(%ebp),%eax
    15f9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  cond->next = NULL;
    15ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1602:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  return;
    1609:	90                   	nop
}
    160a:	5d                   	pop    %ebp
    160b:	c3                   	ret    

0000160c <pthread_cond_wait>:

void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
    160c:	55                   	push   %ebp
    160d:	89 e5                	mov    %esp,%ebp
    160f:	53                   	push   %ebx
    1610:	83 ec 24             	sub    $0x24,%esp
  mpthread_cond_t *mycond = cond;
    1613:	8b 45 08             	mov    0x8(%ebp),%eax
    1616:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pthread_mutex_unlock(mutex);
    1619:	8b 45 0c             	mov    0xc(%ebp),%eax
    161c:	89 04 24             	mov    %eax,(%esp)
    161f:	e8 b3 ff ff ff       	call   15d7 <pthread_mutex_unlock>
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
    1624:	eb 09                	jmp    162f <pthread_cond_wait+0x23>
    mycond = mycond->next;  
    1626:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1629:	8b 40 04             	mov    0x4(%eax),%eax
    162c:	89 45 f4             	mov    %eax,-0xc(%ebp)
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex){
  mpthread_cond_t *mycond = cond;
  pthread_mutex_unlock(mutex);
  
  //iterate the linked-list pointer to the end;
  while(mycond->next != NULL)
    162f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1632:	8b 40 04             	mov    0x4(%eax),%eax
    1635:	85 c0                	test   %eax,%eax
    1637:	75 ed                	jne    1626 <pthread_cond_wait+0x1a>
    mycond = mycond->next;  

  mycond->next = (mpthread_cond_t *)malloc(sizeof(mpthread_cond_t));
    1639:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1640:	e8 b4 fd ff ff       	call   13f9 <malloc>
    1645:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1648:	89 42 04             	mov    %eax,0x4(%edx)
  mycond->next->threadId = getpid();
    164b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164e:	8b 58 04             	mov    0x4(%eax),%ebx
    1651:	e8 8e f9 ff ff       	call   fe4 <getpid>
    1656:	89 03                	mov    %eax,(%ebx)
  mycond->next->next = NULL;
    1658:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165b:	8b 40 04             	mov    0x4(%eax),%eax
    165e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  pthread_mutex_lock(mutex);
    1665:	8b 45 0c             	mov    0xc(%ebp),%eax
    1668:	89 04 24             	mov    %eax,(%esp)
    166b:	e8 46 ff ff ff       	call   15b6 <pthread_mutex_lock>
  pthread_mutex_unlock(mutex);
    1670:	8b 45 0c             	mov    0xc(%ebp),%eax
    1673:	89 04 24             	mov    %eax,(%esp)
    1676:	e8 5c ff ff ff       	call   15d7 <pthread_mutex_unlock>
  threadSleep(mutex);
    167b:	8b 45 0c             	mov    0xc(%ebp),%eax
    167e:	89 04 24             	mov    %eax,(%esp)
    1681:	e8 96 f9 ff ff       	call   101c <threadSleep>
  pthread_mutex_lock(mutex);
    1686:	8b 45 0c             	mov    0xc(%ebp),%eax
    1689:	89 04 24             	mov    %eax,(%esp)
    168c:	e8 25 ff ff ff       	call   15b6 <pthread_mutex_lock>
  return;
    1691:	90                   	nop
}
    1692:	83 c4 24             	add    $0x24,%esp
    1695:	5b                   	pop    %ebx
    1696:	5d                   	pop    %ebp
    1697:	c3                   	ret    

00001698 <pthread_cond_signal>:

void pthread_cond_signal(mpthread_cond_t *cond){
    1698:	55                   	push   %ebp
    1699:	89 e5                	mov    %esp,%ebp
    169b:	83 ec 28             	sub    $0x28,%esp
  mpthread_cond_t *mycond = cond;
    169e:	8b 45 08             	mov    0x8(%ebp),%eax
    16a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(mycond->threadId==-1)
    16a4:	eb 09                	jmp    16af <pthread_cond_signal+0x17>
    mycond = mycond->next;
    16a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a9:	8b 40 04             	mov    0x4(%eax),%eax
    16ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return;
}

void pthread_cond_signal(mpthread_cond_t *cond){
  mpthread_cond_t *mycond = cond;
  while(mycond->threadId==-1)
    16af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b2:	8b 00                	mov    (%eax),%eax
    16b4:	83 f8 ff             	cmp    $0xffffffff,%eax
    16b7:	74 ed                	je     16a6 <pthread_cond_signal+0xe>
    mycond = mycond->next;
  if(mycond!=NULL){
    16b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16bd:	74 33                	je     16f2 <pthread_cond_signal+0x5a>
    int threadId = mycond->threadId;
    16bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c2:	8b 00                	mov    (%eax),%eax
    16c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    mpthread_cond_t *garbage = mycond;
    16c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cond->next = cond->next->next;
    16cd:	8b 45 08             	mov    0x8(%ebp),%eax
    16d0:	8b 40 04             	mov    0x4(%eax),%eax
    16d3:	8b 50 04             	mov    0x4(%eax),%edx
    16d6:	8b 45 08             	mov    0x8(%ebp),%eax
    16d9:	89 50 04             	mov    %edx,0x4(%eax)
    free(garbage);
    16dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16df:	89 04 24             	mov    %eax,(%esp)
    16e2:	e8 d9 fb ff ff       	call   12c0 <free>
    threadWake(threadId);
    16e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16ea:	89 04 24             	mov    %eax,(%esp)
    16ed:	e8 32 f9 ff ff       	call   1024 <threadWake>
  }
  return;
    16f2:	90                   	nop
}
    16f3:	c9                   	leave  
    16f4:	c3                   	ret    

000016f5 <pthread_sem_init>:

void pthread_sem_init(mpthread_sem_t* sem, int flag, int value){
    16f5:	55                   	push   %ebp
    16f6:	89 e5                	mov    %esp,%ebp
    16f8:	83 ec 04             	sub    $0x4,%esp
  sem->value = value;
    16fb:	8b 45 08             	mov    0x8(%ebp),%eax
    16fe:	8b 55 10             	mov    0x10(%ebp),%edx
    1701:	89 10                	mov    %edx,(%eax)
  pthread_cond_init(&sem->cond);
    1703:	8b 45 08             	mov    0x8(%ebp),%eax
    1706:	83 c0 04             	add    $0x4,%eax
    1709:	89 04 24             	mov    %eax,(%esp)
    170c:	e8 e2 fe ff ff       	call   15f3 <pthread_cond_init>
  pthread_mutex_init(&sem->mutex);
    1711:	8b 45 08             	mov    0x8(%ebp),%eax
    1714:	83 c0 0c             	add    $0xc,%eax
    1717:	89 04 24             	mov    %eax,(%esp)
    171a:	e8 88 fe ff ff       	call   15a7 <pthread_mutex_init>
  return;
    171f:	90                   	nop
}
    1720:	c9                   	leave  
    1721:	c3                   	ret    

00001722 <pthread_sem_wait>:

void pthread_sem_wait(mpthread_sem_t* sem){
    1722:	55                   	push   %ebp
    1723:	89 e5                	mov    %esp,%ebp
    1725:	83 ec 18             	sub    $0x18,%esp
  sem->value --;
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
    172b:	8b 00                	mov    (%eax),%eax
    172d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1730:	8b 45 08             	mov    0x8(%ebp),%eax
    1733:	89 10                	mov    %edx,(%eax)
  if(sem->value < 0){
    1735:	8b 45 08             	mov    0x8(%ebp),%eax
    1738:	8b 00                	mov    (%eax),%eax
    173a:	85 c0                	test   %eax,%eax
    173c:	79 18                	jns    1756 <pthread_sem_wait+0x34>
    pthread_cond_wait(&sem->cond, &sem->mutex); 
    173e:	8b 45 08             	mov    0x8(%ebp),%eax
    1741:	8d 50 0c             	lea    0xc(%eax),%edx
    1744:	8b 45 08             	mov    0x8(%ebp),%eax
    1747:	83 c0 04             	add    $0x4,%eax
    174a:	89 54 24 04          	mov    %edx,0x4(%esp)
    174e:	89 04 24             	mov    %eax,(%esp)
    1751:	e8 b6 fe ff ff       	call   160c <pthread_cond_wait>
  }
  return;
    1756:	90                   	nop
}
    1757:	c9                   	leave  
    1758:	c3                   	ret    

00001759 <pthread_sem_post>:

void pthread_sem_post(mpthread_sem_t* sem){
    1759:	55                   	push   %ebp
    175a:	89 e5                	mov    %esp,%ebp
    175c:	83 ec 18             	sub    $0x18,%esp
  sem->value ++;
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	8b 00                	mov    (%eax),%eax
    1764:	8d 50 01             	lea    0x1(%eax),%edx
    1767:	8b 45 08             	mov    0x8(%ebp),%eax
    176a:	89 10                	mov    %edx,(%eax)
  pthread_cond_signal(&sem->cond);
    176c:	8b 45 08             	mov    0x8(%ebp),%eax
    176f:	83 c0 04             	add    $0x4,%eax
    1772:	89 04 24             	mov    %eax,(%esp)
    1775:	e8 1e ff ff ff       	call   1698 <pthread_cond_signal>
  return;
    177a:	90                   	nop
}
    177b:	c9                   	leave  
    177c:	c3                   	ret    
