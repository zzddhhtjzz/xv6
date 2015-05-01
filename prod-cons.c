#include "types.h"
#include "user.h"
#include "x86.h"

#define NULL 0

#define NITER 50
#define SIZE  10

int buffer[SIZE];
int left;
int right;
int count;

mpthread_mutex_t mutex;
mpthread_cond_t empty;
mpthread_cond_t full;

void put(int value){
  buffer[right] = value;
  right = (right +1) % SIZE;
  count ++;
}

int get(){
  int value = buffer[left];
  left = (left + 1) % SIZE;
  count --;
  return value;
} 

void producer(void *arg)
{
  int i; 
  for(i = 0; i< NITER; i++)
  {
    pthread_mutex_lock(&mutex);
    while(count == SIZE)
      pthread_cond_wait(&full, &mutex);
    put(i);
    pthread_cond_signal(&empty);
    pthread_mutex_unlock(&mutex);
  }
  exit();
}

void consumer(void *arg){
  int i;
  for(i=0; i < NITER; i++){
    pthread_mutex_lock(&mutex);
    while(count == 0)
      pthread_cond_wait(&full, &mutex);
    int value = get(i);
    pthread_cond_signal(&full);
    pthread_mutex_unlock(&mutex);
    printf(1, "%d\n", value);
  }
  exit();
}

int main(){
  printf(1, "Parent starts\n");
  
  mpthread_t p1, p2;
  pthread_mutex_init(&mutex);
  pthread_cond_init(&empty);
  pthread_cond_init(&full);
  
  pthread_create(&p1, NULL, producer, NULL);
  pthread_create(&p2, NULL, consumer, NULL);

  pthread_join(p1, NULL);
  pthread_join(p2, NULL);

  exit();
}



