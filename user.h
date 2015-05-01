struct stat;
struct rtcdate;

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(char*, int);
int mknod(char*, short, short);
int unlink(char*);
int fstat(int fd, struct stat*);
int link(char*, char*);
int mkdir(char*);
int chdir(char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int clone(void(*func)(void*), void* arg, void* stack);
int join(int threadId, void** childStack);
void threadSleep(mpthread_mutex_t *mutex);
void threadWake(int threadId);
// ulib.c
int stat(char*, struct stat*);
char* strcpy(char*, char*);
void *memmove(void*, void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, char*, ...);
char* gets(char*, int max);
uint strlen(char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);

int pthread_create(mpthread_t* thread, mpthread_attr_t *attr, void(*func)(void*), void* arg);
int pthread_join(mpthread_t thread, void **retval);
void pthread_mutex_init(mpthread_mutex_t *mutex);
void pthread_mutex_lock(mpthread_mutex_t *mutex);
void pthread_mutex_unlock(mpthread_mutex_t *mutex);

typedef struct mpthread_cond{
  int threadId;
  struct mpthread_cond *next;
}mpthread_cond_t;

typedef struct mpthread_sem{
  int value;
  mpthread_cond_t cond;
  mpthread_mutex_t mutex;
}mpthread_sem_t;

void pthread_cond_init(mpthread_cond_t *cond);
void pthread_cond_wait(mpthread_cond_t *cond, mpthread_mutex_t *mutex);
void pthread_cond_signal(mpthread_cond_t *cond);

void pthread_sem_post(mpthread_sem_t* sem);
void pthread_sem_wait(mpthread_sem_t* sem);
void pthread_sem_init(mpthread_sem_t* sem, int flag, int value);
