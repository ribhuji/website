+++
title = 'Why Our LED Light is Designed to Be A Garbage'
date = 2026-06-19T00:00:00+05:30
draft = false
+++

My LED batton started flickering a while ago. So naturally the electrician suggested to get it replaced, and I did exactly that. But I wanted to understand what went wrong in that batton, and what could I learn from it.

What I found inside was not fun, it was a lesson in why our electronics are designed to become e-waste.

### What's Really Inside?

If you look closely at standard consumer electronics, you quickly realize they are designed to fail at their weakest link. In a standard LED batten, that link is almost *never* the actual LEDs. It's the cheap AC-to-DC driver circuit that runs everything.

Here is the perpetrator on my desk:

![actodc](/images/ACToDCDriver.jpeg)

I asked a large language model to create a diagram of it as well, for better understanding -

![Autopsy of LED batten driver circuit](/images/ACToDCDriverCircuit.png)

### Why 87V is the "Anti-Reuse" Voltage

I looked at the long, beautiful rigid strip of perfectly intact surface-mount LEDs inside and thought I should be able to reus eit somehow.

Standard flexible LED strips we buy for under-cabinet lighting run on a friendly, safe $12\text{V}$ or $24\text{V}$. You can power them with an old router brick. I checked the aluminum backing of my salvaged strip, expecting a simple voltage requirement. Then I saw the markings on the aluminum strip: `(29X3)`.

`29X3`. That is the engineering recipe.

![LEDStripImage](/images/LEDStrip.png)

In the world of LED manufacturing, white surface-mount LEDs have a predictable forward voltage drop of about $3\text{V}$. To maximize efficiency, manufacturers wire them in large, complex groups. The `29X3` code means **29 groups wired in series, with each group containing 3 LEDs wired in parallel**.

Let's do the simple, frustrating math:

$$\text{Total System Voltage} = 29 \text{ groups} \times 3\text{V} \text{ drop/group} = 87\text{V DC}$$

To light this up, you need a high-voltage, constant-current driver. You cannot use a 12V wall adapter, a USB power bank, or a simple battery. By engineering the light for this niche 87V ecosystem, the manufacturer has made the working strip effectively "un-hackable" for the average person.

Another LLM created image to show the parallel configuration:

![Series-parallel wiring breakdown showing 29x3 configuration](/images/SeriesLEDConfig.png)

Could they have built this differently? Absolutely.

If the industry standardized on a modular input (like 12V or 24V), the strip would still be perfectly functional even if the driver died. You could unclip the old driver, buy a new generic power supply, and keep using the light.

But there is one primary reason they chose this high-voltage design: **Cost Optimization at the Expense of Sustainability.**

When a batten sells for ₹100–150 (about $1.50 USD, or higher depending on how bad INR is performing), every paisa of copper counts.

| Feature | High-Voltage Design (Current) | Low-Voltage Modular Design |
| --- | --- | --- |
| **Current Required** | **Very Low** (~230mA) | **Very High** (~1.67A) |
| **Copper Wire (PCB)** | Ultra-Thin (Cheap) | Thick (Expensive) |
| **Transformer Cost** | Low (Small Step-Down) | High (Robust Step-Down) |
| **Estimated Factory Cost** | **~₹70** | **~₹120** |

By choosing 87V, the manufacturer minimizes the current ($I=\frac{P}{V}$), allowing them to use razor-thin copper traces and microscopic wires throughout the 4-foot length of the light. Sustainability is deliberately sacrificed to keep the retail price below ₹150.

### My Conclusion/ Rant

We are living in an era where we can buy a bright, efficient, 20-watt light fixture for lesser than the price of a cup of coffee at Third Wave. But we are paying for that low price with the planet. Because the driver and the strip are locked in a dependency that only makes economic sense at ₹150, the moment the 5-rupee capacitor fails, the entire fixture is sentenced to a landfill.

We need to push for circular design, where the light panel and the power source are modular. We need to be climate first and we need to design things that can be hacked and reused.