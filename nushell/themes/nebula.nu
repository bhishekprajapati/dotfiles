# Nebula — deep indigo void with electric-blue/cyan/magenta swirl accents for Nushell
# Matches the kitty "Nebula" theme (confs/nebula.conf), sourced from a
# cyan/magenta/violet paint-marble wallpaper.
#
# Activate by sourcing from config.nu:
#     source ~/.config/nushell/nebula.nu

# Retrieve the theme settings
export def main [] {
    return {
        binary: '#D946EF'
        block: '#4F7CFF'
        cell-path: '#8B88A8'
        closure: '#2DD4E6'
        custom: '#D6D4E8'
        duration: '#F2C14E'
        float: '#FF4D6D'
        glob: '#8B88A8'
        int: '#F472E0'
        list: '#34D399'
        nothing: '#FF4D6D'
        range: '#F2C14E'
        record: '#2DD4E6'
        string: '#34D399'

        bool: {|| if $in { '#34D399' } else { '#F2C14E' } }

        datetime: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#FF4D6D' attr: 'b' }
            } else if $in < 6hr {
                '#FF4D6D'
            } else if $in < 1day {
                '#F2C14E'
            } else if $in < 3day {
                '#34D399'
            } else if $in < 1wk {
                { fg: '#34D399' attr: 'b' }
            } else if $in < 6wk {
                '#2DD4E6'
            } else if $in < 52wk {
                '#4F7CFF'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#8B88A8'
            } else if $e < 1mb {
                '#2DD4E6'
            } else {{ fg: '#F2C14E' }}
        }

        shape_and: { fg: '#D946EF' attr: 'b' }
        shape_binary: { fg: '#D946EF' attr: 'b' }
        shape_block: { fg: '#4F7CFF' attr: 'b' }
        shape_bool: '#2DD4E6'
        shape_closure: { fg: '#2DD4E6' attr: 'b' }
        shape_custom: '#34D399'
        shape_datetime: { fg: '#2DD4E6' attr: 'b' }
        shape_directory: '#F2C14E'
        shape_external: '#F472E0'
        shape_external_resolved: '#FFD873'
        shape_externalarg: { fg: '#34D399' attr: 'b' }
        shape_filepath: '#F472E0'
        shape_flag: { fg: '#7C9BFF' attr: 'b' }
        shape_float: { fg: '#FF4D6D' attr: 'b' }
        shape_garbage: { fg: '#F4F3FB' bg: '#FF4D6D' attr: 'b' }
        shape_glob_interpolation: { fg: '#2DD4E6' attr: 'b' }
        shape_globpattern: { fg: '#2DD4E6' attr: 'b' }
        shape_int: { fg: '#D946EF' attr: 'b' }
        shape_internalcall: { fg: '#F2C14E' attr: 'b' }
        shape_keyword: { fg: '#FF4D6D' attr: 'b' }
        shape_list: { fg: '#2DD4E6' attr: 'b' }
        shape_literal: '#4F7CFF'
        shape_match_pattern: '#34D399'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#FF4D6D'
        shape_operator: '#F2C14E'
        shape_or: { fg: '#D946EF' attr: 'b' }
        shape_pipe: { fg: '#4F7CFF' attr: 'b' }
        shape_range: { fg: '#F2C14E' attr: 'b' }
        shape_raw_string: { fg: '#8B88A8' attr: 'b' }
        shape_record: { fg: '#2DD4E6' attr: 'b' }
        shape_redirection: { fg: '#D946EF' attr: 'b' }
        shape_signature: { fg: '#34D399' attr: 'b' }
        shape_string: '#34D399'
        shape_string_interpolation: { fg: '#2DD4E6' attr: 'b' }
        shape_table: { fg: '#4F7CFF' attr: 'b' }
        shape_vardecl: { fg: '#F2C14E' attr: 'u' }
        shape_variable: '#F2C14E'

        foreground: '#D6D4E8'
        background: '#0A0A18'
        cursor: '#E6E6E6'

        empty: '#4F7CFF'
        header: { fg: '#D946EF' attr: 'b' }
        hints: '#4A4768'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#F2C14E' attr: 'b' }
        search_result: { fg: '#0A0A18' bg: '#2DD4E6' }
        separator: '#4A4768'
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'

    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
