#include <stdlib.h>
#include <signal.h>
#include <sys/neutrino.h>

void __flush_init (void) ATTRIBUTE_HIDDEN; 

static int suspend_other_threads = 1;


void flush_cov_data(int signo) {
	if(suspend_other_threads)
		ThreadCtl(_NTO_TCTL_THREADS_HOLD, 0);	
	__gcov_flush();
	if(suspend_other_threads)
		ThreadCtl(_NTO_TCTL_THREADS_CONT, 0);
}

void flush_init(void) {
	int sigNo = SIGUSR2;
    char* s;
    s = getenv( "COV_DATA_FLUSH" );
    if( s != 0 ) {
        sigNo = atoi(s);
    }
    s = getenv( "COV_NO_SUSPEND_THREADS" );
    if(0 != s)
    	suspend_other_threads=0;
    if(sigNo > 0) // Use 0 to disable signal trap
    	signal(sigNo, flush_cov_data);
}