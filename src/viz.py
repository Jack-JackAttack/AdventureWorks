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
    show_values=True,
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
                fontsize = 12
            )

    ax.set_title(title, fontsize=14, fontweight="bold")
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel, fontsize=12)
    ax.grid(grid, axis="x", linestyle="--", alpha=0.6)

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
