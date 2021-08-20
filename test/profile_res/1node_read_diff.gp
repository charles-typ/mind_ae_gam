#!/usr/local/bin/gnuplot

# Note you need gnuplot 4.4 for the pdfcairo terminal.

set terminal pdfcairo font "Gill Sans, 20" linewidth 4 rounded
set term postscript eps color linewidth 4 rounded
# Line style for axes
set style line 80 lt rgb "#808080"

set size 1, 1

# Line style for grid
set style line 81 lt 0  # dashed
set style line 81 lt rgb "#808080"  # grey

set grid back linestyle 81
set border 3 back linestyle 80 # Remove border on top and right.  These
             # borders are useless and make it harder
             # to see plotted lines near the border.
    # Also, put it in grey; no need for so much emphasis on a border.
set xtics 100 nomirror font "Helvetica, 20"
set ytics nomirror font "Helvetica, 20"

#set log x
#set log y
#set mxtics 10    # Makes logscale look good.
#set mytics 10

# Line styles: try to pick pleasing colors, rather
# than strictly primary colors or hard-to-see colors
# like gnuplot's default yellow.  Make the lines thick
# so they're easy to see in small plots in papers.
set style line 1 lt 1 linecolor rgb "#A00000" lw 1 pt -1
set style line 2 lt 1 linecolor rgb "#00A000" lw 1 pt -1
set style line 3 lt 1 linecolor rgb "#5060D0" lw 1 pt -1
set style line 4 lt 2 linecolor rgb "#FF8C00" lw 1 pt 4

set output "./1node_read_diff.eps"
set xlabel "Pass" font "Helvetica, 20"
set ylabel "Latency(ns)" font "Helvetica, 20"

set key horizontal reverse above font "Helvetica, 20" maxrows 2 samplen 0.5 width -1

#set xrange [0:500]
#set yrange [:60]

plot "./1node_thread0_read" using 1:2 title "1node read" w lp ls 1,\
    "./2node_thread0_read" using 1:2 title "2node read" w lp ls 2,\
    "./3node_thread0_read" using 1:2 title "3node read" w lp ls 3,\
    "./4node_thread0_read" using 1:2 title "4node read" w lp ls 4

#plot "../data/read_latency.tsv" using 1:($2/1000) title "S3" w lp ls 1,\
#  "../data/read_latency.tsv" using 1:($3/1000) title "DynamoDB" w lp ls 2,\
#  "../data/read_latency.tsv" using 1:($4/1000) title "Apache Crail" w lp ls 3,\
#  "../data/read_latency.tsv" using 1:($5/1000) title "ElastiCache" w lp ls 4
