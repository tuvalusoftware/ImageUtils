
#ifndef __LAYOUT_H
#define __LAYOUT_H


typedef struct {
	int		iw, ih, ow, oh;
	int		oi, oj;
	float	ar, ar_ret;
	float	ds;			// desired normalized size
	char	*fileNamePath;
} Photo;


#endif // __LAYOUT_H


