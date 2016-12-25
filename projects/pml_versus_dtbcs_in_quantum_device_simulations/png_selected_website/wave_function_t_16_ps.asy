import settings;
import math;
import graph;
import palette;
import contour;

import settings_article;

texpreamble("
\usepackage{bm}
");

size(72.5mm, 0);


pen[] Palette = Gradient(NColors=256 ... new pen[]{white, blue, cyan, green, yellow, orange, red, palered, white});

real palette_min = 0.0;
real palette_max = 4.0;


string filename;
file in;

filename = "../data_selected/psi_dtbc_2nd_cn_t_16_ps.dat";
in = input(filename).line();
real[][] phi_pml = in.dimension(0,0);
close(in);

filename = "../data_selected/V_device.dat";
in = input(filename).line();
real[][] V_device = in.dimension(0,0);
close(in);


real time_in_ps = 16.0;

real L1_device = 300;
real L2_device = 90;




bounds range = image(phi_pml, 
					 range=Range(palette_min, palette_max), 
					 (0,0), 
					 (L1_device,L2_device), 
				     Palette, 
					 antialias=true);

draw(contour(V_device,  (0,0), (L1_device,L2_device), new real[]{0.2}), black+0.4);


draw((0,L2_device)--(L1_device,L2_device), black);
draw((L1_device, 0.0)--(L1_device,L2_device), black);

/*
real r0 = 10.0;
draw(circle((0.5*L1_device,0.5*L2_device), r0), black+0.4+longdashed);

path c1 = scale(1.5) * unitcircle;
fill(shift(0.5*L1_device,0.5*L2_device)*c1, black);
*/

xaxis(
	"$x_1$ in nm",  
	Bottom, 
	RightTicks( 
		begin = true, 
		beginlabel = true, 
		end = true, 
		endlabel = true,
		step =  50.0,  
		Step = 100.0, 
		size = tick_size_small,
		Size = tick_size_large
	),
	above=true
);

yaxis(
	"$x_2$ in nm",  
	Left, 
	black, 
	LeftTicks( 
		begin = true, 
		beginlabel = true, 
		end = true, 
		endlabel = true,
		step = 30.0,
		Step = 90.0, 
		size = tick_size_small,
		Size = tick_size_large	
	),
	above=true
);
	





string string_time = "$t=$" + format("\,$%#3.1f$", time_in_ps) + "\,ps";
label(string_time, point(N)+(0,0), N);


shipout(format="eps");




