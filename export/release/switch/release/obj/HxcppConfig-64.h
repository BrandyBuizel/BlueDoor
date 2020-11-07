#ifndef HXCPP_CONFIG_INCLUDED
#define HXCPP_CONFIG_INCLUDED

#if !defined(NN_NINTENDO_SDK) && !defined(NO_NN_NINTENDO_SDK)
#define NN_NINTENDO_SDK 
#endif

#if !defined(NN_SDK_BUILD_RELEASE) && !defined(NO_NN_SDK_BUILD_RELEASE)
#define NN_SDK_BUILD_RELEASE 
#endif

#if !defined(LIME_SWITCH) && !defined(NO_LIME_SWITCH)
#define LIME_SWITCH 
#endif

#if !defined(LIME_SDL_SYSWM_EVENTS) && !defined(NO_LIME_SDL_SYSWM_EVENTS)
#define LIME_SDL_SYSWM_EVENTS 
#endif

#if !defined(HXCPP_ARM64) && !defined(NO_HXCPP_ARM64)
#define HXCPP_ARM64 
#endif

#if !defined(HXCPP_M64) && !defined(NO_HXCPP_M64)
#define HXCPP_M64 
#endif

#if !defined(HXCPP_VISIT_ALLOCS) && !defined(NO_HXCPP_VISIT_ALLOCS)
#define HXCPP_VISIT_ALLOCS 
#endif

#if !defined(HXCPP_API_LEVEL) && !defined(NO_HXCPP_API_LEVEL)
#define HXCPP_API_LEVEL 331
#endif

#include <hxcpp.h>

#endif
