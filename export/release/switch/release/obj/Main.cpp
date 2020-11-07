#include <stdio.h>

#ifdef HX_WINDOWS
#include <windows.h>
#endif

extern "C" const char *hxRunLibrary ();
extern "C" void hxcpp_set_top_of_stack ();

extern "C" int lime_cairo_register_prims ();

extern "C" int lime_register_prims ();

extern "C" void nnMain() {

	hxcpp_set_top_of_stack ();
	
	lime_cairo_register_prims ();
	
	lime_register_prims ();
	
	const char *err = NULL;
 	err = hxRunLibrary ();
	
	if (err) {
		
		printf("Error: %s\n", err);
		
	}
	
}
/*
// TODO: remove workaround to SDL using pthread_detach.
// NNSDK does not implement pthread_detach. Or maybe we're missing something.
// Otherwise, SDL-switch needs a patch.
extern "C" int pthread_detach(void *p) {
	return 0;
}
*/