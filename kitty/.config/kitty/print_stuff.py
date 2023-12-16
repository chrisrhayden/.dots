from kitty.cli import create_default_opts

def main(args):
    opts = create_default_opts()
    bg = opts.background.as_sharp
    opacity = opts.background_opacity

    print(bg, "\n" + str(opacity))
