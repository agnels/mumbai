set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
proc finish {} {
        global ns nf
        $ns flush-trace
        close $nf
        exec nam out.nam &
        exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#n1,n3 AP

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail

$ns duplex-link-op $n0 $n1 orient right     
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n1 $n3 orient right-down

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n3 $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

set null0 [new Agent/Null] 
$ns attach-agent $n2 $null0
set null1 [new Agent/Null] 
$ns attach-agent $n0 $null1

$udp0 set class_ 1
$udp1 set class_ 2

$ns color 1 Blue
$ns color 2 Red

$ns connect $udp0 $null0
$ns connect $udp1 $null1
$ns at 0.0 "$n1 label AP"
$ns at 0.0 "$n0 color green"
$ns at 0.0 "$n2 color magenta"
$ns at 0.0 "$n3 color green"
$ns at 0.5 "$cbr0 start"
$ns at 0.9 "$cbr1 start"
$ns at 4.9 "$cbr1 stop"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run
