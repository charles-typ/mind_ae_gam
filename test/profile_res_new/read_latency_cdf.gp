#!/usr/local/bin/gnuplot

# Note you need gnuplot 4.4 for the pdfcairo terminal.

set terminal pdfcairo font "Gill Sans, 20" linewidth 4 rounded
set term postscript eps color linewidth 4 rounded
# Line style for axes
set style line 80 lt rgb "#808080"

#set size 0.5, 0.5

# Line style for grid
set style line 81 lt 0  # dashed
set style line 81 lt rgb "#808080"  # grey

set grid back linestyle 81
set border 3 back linestyle 80 # Remove border on top and right.  These
             # borders are useless and make it harder
             # to see plotted lines near the border.
    # Also, put it in grey; no need for so much emphasis on a border.
set xtics nomirror font "Helvetica, 20"
set ytics nomirror font "Helvetica, 20"

set log x
#set log y
set mxtics 10    # Makes logscale look good.
#set mytics 10

# Line styles: try to pick pleasing colors, rather
# than strictly primary colors or hard-to-see colors
# like gnuplot's default yellow.  Make the lines thick
# so they're easy to see in small plots in papers.
set style line 1 lt 1 linecolor rgb "#A00000" lw 1 pt -1
set style line 2 lt 1 linecolor rgb "#00A000" lw 1 pt -1
set style line 3 lt 1 linecolor rgb "#5060D0" lw 1 pt -1
set style line 4 lt 2 linecolor rgb "#FF8C00" lw 1 pt -1
set style line 5 lt 1 lw 1 pt -1

set output "./write_latency_cdf.eps"
set xlabel "Write latency(ns)" font "Helvetica, 20"
set ylabel "CDF" font "Helvetica, 20"

set key noopaque at graph 1.03,0.6 font "Helvetica, 20" samplen 1 width -1

#set ytics ("" 0, "0.2" 0.2, "0.4" 0.4, "0.6" 0.6, "0.8" 0.8, "1.0" 1.0)
#set xtics ("0.1ms" 100, "1ms" 1000, "10ms" 10000, "0.1s" 100000, "1s" 1000000, "10s" 10000000)

#set xrange [100:10000000]
#set yrange [1:]

plot "./write_cdf.txt" using 1:($2/100) title "Write" w lp ls 1
