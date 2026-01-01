def bar(
    ax,
    df,
    x_col,
    y_col,
    title,
    xlabel,
    ylabel,
    color="steelblue",
    alpha=0.9,
    show_values=True,
    grid=True
):
    x = df[x_col]
    y = df[y_col]

    bars = ax.bar(x, y, color=color, alpha=alpha)

    if show_values:
        for bar in bars:
            height = bar.get_height()
            ax.text(
                bar.get_x() + bar.get_width() / 2,
                height,
                f"{int(height)}",
                ha="center",
                va="bottom"
            )

    ax.set_title(title, fontsize=14, fontweight="bold")
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel, fontsize=12)
    ax.grid(grid, axis="y", linestyle="--", alpha=0.6)

    return ax


from matplotlib.ticker import FuncFormatter
def barh(
    ax,
    df,
    x_col,
    y_col,
    title,
    xlabel,
    ylabel,
    color="steelblue",
    alpha=0.9,
    fontsize=12,
    fontsize_title=14,
    fontsize_ylabel=14,
    show_values=True,
    scale=1_000_000,
    grid=True
):
    y = df[y_col]
    x = df[x_col]

    bars = ax.barh(y, x, color=color, alpha=alpha)

    if show_values:
        for bar in bars:
            width = bar.get_width()
            ax.text(
                width * 0.95,
                bar.get_y() + bar.get_height() / 2,
                f"{width/1_000_000:.1f} Mkr",
                va = "center",
                ha = "left",
                color = "black",
                fontsize = fontsize
            )

    ax.set_title(title, fontsize=fontsize_title, fontweight="bold")
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel, fontsize=fontsize_ylabel)
    ax.grid(grid, axis="x", linestyle="--", alpha=0.6)

    #innan var skalan 1-5(1e7) på vänster y-axel. Jag ville ha den skalan från 10-50 istället. Alltså i mkr istället för kr.
    ax.xaxis.set_major_formatter(   #betyder typ "såhär ska huvudettiketterna (1,2,3...) skrivas". Den ändrar texten inte värdena.
        FuncFormatter(lambda x, _: f"{x / scale:.0f}") #använder bara första argumentet "x" inte andra "_". Betyder, ta ax(vänstar y-värdet) dela med 1 milj, visa som heltal. Bytte ut 1mkr mot "scale" så jag kan välja skala i ipynb.
    )

    return ax


import matplotlib.dates as mdates
def line(
    ax,
    df,
    x_col,
    y_col,
    title,
    xlabel,
    ylabel,
    color="steelblue",
    linestyle="-",
    linewidth=2,
    marker=None,
    grid=True
):
    x = df[x_col]
    y = df[y_col]

    ax.plot(
        x,
        y,
        color=color,
        linewidth=linewidth,
        linestyle=linestyle,
        marker=marker
    )

    ax.set_title(title, fontsize=14, fontweight="bold")
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel, fontsize=12)
    ax.grid(grid, axis="both", linestyle="--", alpha=0.6)
    ax.tick_params(axis="x", rotation=90)
    ax.xaxis.set_major_locator(mdates.MonthLocator(interval=1))

    return ax




def add_bar_values(
    ax,
    bars,
    formatter,
    fontsize=11,
    color="black",
    padding=3
):
    for bar in bars: #loopar igenom varje bar
        height = bar.get_height()   #tar fram höjden för varje bar
        ax.text(    #Skriv texten på kordinaten (x,y)
            bar.get_x() + bar.get_width() / 2,  #tar x position och räknar ut mitten (blir 0,1,2,..)
            height + padding,   #tar ut höjden och lägger på lite padding
            formatter(height),  #formarterar om höjden t.ex. "Intäkt" från siffra till text enligt lambda funktionen jag skickade in nedan.
            ha="center", #centrerar texten, horisontell alignment
            va="bottom", #vertikal alignment
            fontsize=fontsize,
            color=color
        )




import numpy as np
from matplotlib.ticker import FuncFormatter
def grouped_bar(
        ax,
        df,
        x_col,
        y_col1,
        y_col2,
        label1,
        label2,
        title,
        xlabel,
        ylabel1,
        ylabel2,
        color1="steelblue",
        color2="darkorange",
        width=0.3,
        grid=True,
        show_values=True
):
    x_labels = df[x_col] #(1.)lista av t.ex. alla år. Detta ska visas på x-axeln. Första stapeln blir då 2022.
    x = np.arange(len(x_labels)) #(2.)skapar en array från 0,1,2 osv

    ax2 = ax.twinx() #skapa en ny y-axel (till höger) som delar samma x-axel som "ax"

    bars1 = ax.bar(     #rita staplar på axeln ax, alltså vänster y-axel
        x - width / 2,  #första x värdet i arrayn är 0. så width(0.3) / 2 = 0.15.  0 - 0.15 = -0.15. Alltså flytta till vänster. Sedan fortsätt i arrayn.
        df[y_col1],     #plockar ut alla värden ur den kolumn du vill ha på vänstra y-axeln. t.ex. "Intäkt"
        width,          #stapelns bredd i x-axeln. Har inget med värdet att göra, bara utseende.
        label=label1,   #texten som visas i legenden
        color=color1    #färgen på staplarna
    ) #i bars1 sparas typ en lista av stapel-objekt. Alltså typ bars1 = [bar_2022, bar_2023, bar_2024]. Varje bar vet sin höjd,position osv.

    bars2 = ax2.bar(    #rita staplar på axeln ax2, alltså höger y-axel
        x + width / 2,  # istället för - tar vi + här. Så vi ritar stapeln till höger om den första stapeln.
        df[y_col2],     #plockar ut alla värden ur den kolumn du vill ha på högra y-axeln. t.ex. "AntalOrdrar"
        width,
        label=label2,
        color=color2
    )

    ax.set_xticks(x) #(2.)här säger vi vart staplarna ska ritas
    ax.set_xticklabels(x_labels) #(1.)här säger vi vad som ska stå under staplarna

    ax.set_title(title, fontsize=14, fontweight="bold")
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel1, fontsize=12)
    ax2.set_ylabel(ylabel2, fontsize=12)
    ax.grid(grid, axis="y", linestyle="--", alpha=0.6)


    #innan var skalan 1-5(1e7) på vänster y-axel. Jag ville ha den skalan från 10-50 istället. Alltså i mkr istället för kr.
    ax.yaxis.set_major_formatter(   #betyder typ "såhär ska huvudettiketterna (1,2,3...) skrivas". Den ändrar texten inte värdena.
        FuncFormatter(lambda x, _: f"{x / 1_000_000:.0f}") #använder bara första argumentet "x" inte andra "_". Betyder, ta ax(vänstar y-värdet) dela med 1 milj, visa som heltal.
    )

    ax.legend(  #lägger til en legend
        [bars1[0], bars2[0]],   #eftersom allar staplarna i bars1 är samma tar vi bara första, likadant i bars2.
        [label1, label2]        #texterna som tillhör symbolerna. Alltså den blå kvadraten blir t.ex. "Total försäljning", orange kvadraten blir t.ex. "Antal ordrar"
    )

    if show_values: #om show_values är true "visa värdena ovanpå staplarna"
        add_bar_values( #anropar funktionen som placerar texten ovanpå staplarna
            ax,     #skickar koordinatsystemet (vänster y-axel) där texten ska ritas
            bars1,  #skickar info som lista för varje bar, t.ex. sin x-position, sin bredd,höjd osv.
            formatter=lambda v: f"{v/1_000_000:.1f} Mkr" #skickar en funktion som tar ett tal och returnerar en text
        )
        add_bar_values(
            ax2,
            bars2,
            formatter=lambda v: f"{int(v):,}".replace(",", " ")
        )

    return ax, ax2