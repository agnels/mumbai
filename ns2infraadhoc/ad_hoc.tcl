set val(chan) Channel/WirelessChannel ;
set val(prop) Propagation/TwoRayGround ;
set val(netif) Phy/WirelessPhy ;
set val(mac) Mac/802_11 ;
set val(ifq) Queue/DropTail/PriQueue ;
set val(ll) LL ;
set val(ant) Antenna/OmniAntenna ;
set val(ifqlen) 50 ;
set val(nn) 5 ;
set val(rp) AODV ;
set val(x) 350 ;
set val(y) 350 ;
set val(stop) 10 ;

set ns [new Simulator]
set tracefd [open thesis.tr w]
set namtrace [open thesis.nam w]

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

set topo [new Topography]

$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace ON

$ns node-config  -energyModel EnergyModel \
-initialEnergy 20 \
-txPower 0.744 \
-rxPower 0.0648 \
-idlePower 0.05 \
-sensePower 0.0175

for {set i 0} {$i < $val(nn) } { incr i } {
set n($i) [$ns node]
}

$n(0) set initialEnergy 5
$n(1) set initialEnergy 25
$n(2) set initialEnergy 15

$n(0) set X_ 100.0
$n(0) set Y_ 200.0
$n(0) set Z_ 0.0

$n(1) set X_ 200.0
$n(1) set Y_ 150.0
$n(1) set Z_ 0.0

$n(2) set X_ 100.0
$n(2) set Y_ 50.0
$n(2) set Z_ 0.0

$n(3) set X_ 300.0
$n(3) set Y_ 200.0
$n(3) set Z_ 0.0

$n(4) set X_ 300.0
$n(4) set Y_ 50.0
$n(4) set Z_ 0.0

for {set i 0 } { $i < 5} { incr i } {
set udp($i) [new Agent/TCP/Newreno]
set sink($i) [new Agent/TCPSink]
$ns attach-agent $n(1) $udp($i)
$ns attach-agent $n($i) $sink($i)
$ns connect $udp($i) $sink($i)
set cbr($i) [new Application/Traffic/CBR]
$cbr($i) set packetSize_ 500
$cbr($i) set interval_ 0.005
$cbr($i) attach-agent $udp($i)
$ns at $i "$cbr($i) start"
}

for {set i 0} {$i < $val(nn)} { incr i } {
$ns initial_node_pos $n($i) 60
$ns at 0.0 "$n($i) label STA"
$ns at $val(stop) "$n($i) reset";
}
$ns at 0.0 "$n(1) label AP"
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at 10.01 "puts \"end simulation\" ; $ns halt"
proc stop {} {
global ns tracefd namtrace
$ns flush-trace
close $tracefd
close $namtrace
exec nam thesis.nam &
exit 0
}
$ns run
