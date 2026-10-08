+++
title = 'Why Cheap LED Battens Are Difficult to Repair'
slug = 'why-our-led-light-is-designed-to-be-a-garbage'
url = '/why-our-led-light-is-designed-to-be-a-garbage/'
date = 2026-06-19T00:00:00+05:30
draft = false
+++

My LED batten started flickering a while ago. The electrician suggested replacing it, and I did exactly that. But I wanted to understand what had gone wrong, so I kept the old one and opened it up.

This is a small teardown, not a controlled failure analysis. I did not electrically verify the failed component, and I do not know the product's rated LED current or the manufacturer's intended circuit topology. Those limits matter.

### What I found

The batten contained two separable parts: a long LED strip on an aluminium backing and a small AC-to-DC driver board. The board contains a mains input, rectifier and capacitors, a transformer, and switching components. From a photograph alone, I cannot identify the exact topology or the failed part.

![The removed AC-to-DC driver board, photographed after the teardown](/images/ACToDCDriver.jpeg)

*The removed driver board. This shows the board and its components; it does not, by itself, prove which component failed.*

The flicker made the driver my leading suspect, because the strip looked intact and the driver is the part that converts mains power into a regulated LED supply. That is still a hypothesis. A failed LED, cracked solder joint, connector, or thermal problem could also produce similar symptoms. I did not measure the strip and driver under controlled conditions, so “the driver failed” would be stronger than the evidence allows.

![AI-generated explanatory illustration of the driver board and possible failure areas](/images/ACToDCDriverCircuit.png)

*AI-generated explanatory illustration, not a circuit trace or failure diagnosis. The labels are illustrative and should not be read as measurements from this board.*

### An estimate from the strip marking

The strip looked reusable, which was the part I found frustrating. It was a long, rigid aluminium-backed board populated with surface-mount white LEDs.

The aluminium backing was marked `29X3`:

![Aluminium-backed LED strip marked 29X3](/images/LEDStrip.png)

*The strip marking is visible above the LEDs. This is the evidence for the `29X3` observation; it does not specify the LED current or confirm the internal wiring by itself.*

I interpret that marking as 29 series groups, with three LEDs in parallel in each group. That convention is plausible for this kind of strip, but it is an interpretation rather than a decoded manufacturer specification. The visible board layout supports it, but tracing every connection or measuring the strip would be stronger evidence.

White LEDs often have a forward voltage in the neighbourhood of 3 V, but the value depends on LED construction, current, temperature, and binning. For example, a [Cree white LED datasheet](https://downloads.cree-led.com/files/ds/x/XLamp-XE-G.pdf) gives a typical forward voltage of 2.9 V and a maximum of 3.25 V at one specified test condition. That is why I use 3 V here as an estimate, not as a universal constant.

Under that assumption, the voltage across 29 series groups would be:

<p class="equation"><strong>V<sub>LED</sub> ≈ 29 × 3 V = 87 V DC</strong></p>

The actual operating voltage would vary with current and temperature, and a driver would need some voltage headroom for current regulation. The strip therefore is not an “87 V part” in the same sense as a regulated 87 V power adapter. It is a high-voltage LED load that needs a suitably matched driver.

![AI-generated explanatory diagram of the 29-by-3 series-parallel interpretation](/images/SeriesLEDConfig.png)

*AI-generated explanatory diagram, based on the `29X3` interpretation above. It is not a measurement of this strip and is not evidence that the driver output was exactly 87 V.*

### Current and driver choice

The current can be estimated only if the LED power is known. If this were a 20 W strip operating at about 87 V, then:

<p class="equation"><strong>I ≈ P / V = 20 W / 87 V ≈ 0.23 A</strong></p>

That 230 mA is an example based on an assumed 20 W rating, not a measurement from this batten. In a three-way parallel group, the branch current would also depend on how well the LEDs match; it would not be safe to assume exactly one-third of the driver current without measurements.

LED drivers commonly regulate current rather than simply presenting a fixed voltage. [Texas Instruments explains why](https://www.ti.com/lit/an/slyt084/slyt084.pdf): small changes in LED forward voltage can produce much larger changes in current, and parallel LED strings can need ballast or current-sharing measures. A high-voltage series arrangement reduces current for a given optical power, which can reduce conductor and conversion losses. It also creates a less convenient replacement part than a common 12 V or 24 V constant-voltage strip.

### Why repair is difficult

The problem is not that 87 V is inherently a bad engineering choice. It can be an efficient way to run a long LED string. The repairability problem is the coupling: the strip, its current, its voltage range, its connectors, and its driver are sold as one opaque assembly. If the driver fails, a working strip is not immediately useful with the 12 V adapters and LED-strip controllers most people already have.

A lower-voltage modular design would bring different trade-offs. At the same power, 24 V would require about 3.6 times as much current as 87 V, which can mean more copper, more conduction loss, or shorter runs. A modular product could still justify those costs if the driver were replaceable, the LED electrical requirements were documented, and the connector and mounting system were standardized.

There is also a safety boundary here. The input is connected to mains, and the driver output may be high-voltage DC. Capacitors can retain charge after unplugging. Do not power or probe an exposed driver or LED strip unless you are trained to work safely on mains-connected equipment and have verified the circuit is de-energized. For an inexperienced reader, the safe repair is replacement by a qualified person, not an improvised test with a phone charger or bench supply. [OSHA's electrical-work guidance](https://www.osha.gov/laws-regs/regulations/standardnumber/1910/1910.333) describes de-energization and precautions around exposed energized parts.

### Conclusion

This teardown did not prove that the manufacturer chose the design to make it fail, or that the driver was definitely the failed component. It showed something more ordinary and more useful: a low-cost fixture can be electrically sensible while still being difficult to repair because its parts are not modular or documented.

I would like to see replaceable drivers, published LED voltage and current ranges, accessible connectors, and mechanical designs that let the light engine survive a driver replacement. That would preserve the efficiency benefits of series LEDs while making reuse less of a guessing game. Not every LED product needs the same architecture, but more products should make the boundary between “replace the driver” and “discard the whole light” explicit.

#### Sources

- [Cree XLamp XE-G white LED datasheet](https://downloads.cree-led.com/files/ds/x/XLamp-XE-G.pdf), for an example of forward-voltage variation with operating condition.
- [Texas Instruments, “LED-driver considerations”](https://www.ti.com/lit/an/slyt084/slyt084.pdf), for constant-current drive, forward-voltage variation, and parallel-string considerations.
- [OSHA 1910.333, selection and use of electrical work practices](https://www.osha.gov/laws-regs/regulations/standardnumber/1910/1910.333), for de-energization and work near exposed energized parts.
