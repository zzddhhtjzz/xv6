#include "types.h"
#include "user.h"
#include "x86.h"

static volatile int counter = 0;
pthread_mutex_t mutex;

void *myThread(void *arg)
{
	printf(1, "%s: begin\n", (char *)arg);
	int i;
	for (i = 0; i < 10000000; i++)
	{
		pthread_mutex_lock(&mutex);
		counter = counter + 1;
		pthread_mutex_unlock(&mutex);
	}
	printf(1, "%s: done\n", (char *)arg);
	return NULL;
}
int main()
{
	// Start
	
	pthread_mutex_init(&mutex);
	printf(1, "main: begin (counter = %d)\n", counter);
	// Create threads
	pthread_t p1, p2;
	pthread_create(&p1, NULL, myThread, "A");
	pthread_create(&p2, NULL, myThread, "B");
	// Wait for threads
	pthread_join(p1, NULL);
	pthread_join(p2, NULL);
	// Done
	printf(1, "main: done with both (counter = %d)\n", counter);
	return 0;
	exit();
}
