#include "types.h"
#include "user.h"
#include "x86.h"

#define NULL 0

mpthread_sem_t forks[5];
mpthread_mutex_t mutex;
int left(int p)
{
    return p;
}
int right(int p)
{
    return (p + 1) % 5;
}
void getForks(int p)
{
    pthread_mutex_lock(&mutex);
    printf(1, "%d tries to get forks\n", p);
    pthread_mutex_unlock(&mutex);

    if(p == 4){
      pthread_sem_wait(&forks[left(p)]);
      pthread_sem_wait(&forks[right(p)]);
    }
    else{
      pthread_sem_wait(&forks[right(p)]);
      pthread_sem_wait(&forks[left(p)]);
    }
    pthread_mutex_lock(&mutex);
    printf(1, "%d gets the forks\n", p);
    pthread_mutex_unlock(&mutex);
}
void putForks(int p)
{
    pthread_mutex_lock(&mutex);
    printf(1, "%d puts the forks\n", p);
    pthread_mutex_unlock(&mutex);

    pthread_sem_post(&forks[left(p)]);
    pthread_sem_post(&forks[right(p)]);
}
void philosopher(void *arg)
{
    int i;
    long p = (long) arg;
    while (1)
    {
        // Think
        for (i = 0; i < 100000; i++);
        // Get forks
        getForks(p);
        // Eat
        for (i = 0; i < 100000; i++);
        // Put forks
        putForks(p);
    }
    exit();
}
int main()
{
    pthread_mutex_init(&mutex);
    // Initialize semaphores
    long i;
    for (i = 0; i < 5; i++)
        pthread_sem_init(&forks[i], 0, 1);
    // Create child threads
    mpthread_t p[5];
    for (i = 0; i < 5; i++)
        pthread_create(&p[i], NULL, philosopher, (void *) i);
    // Wait for children
    for (i = 0; i < 5; i++)
        pthread_join(p[i], NULL);
    // Done
    return 0;
}
