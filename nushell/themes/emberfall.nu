export def main [] {
  return {
    binary: '#B5697A'
    block: '#7B8A94'
    cell-path: '#CBB699'
    closure: '#8FA79C'
    custom: '#E4D3B8'
    duration: '#E09A45'
    float: '#E05A38'
    glob: '#CBB699'
    int: '#CE8895'
    list: '#8FA79C'
    nothing: '#C4432C'
    range: '#E09A45'
    record: '#8FA79C'
    string: '#A9AC6E'
    bool: {|| if $in { '#A9C0B4' } else { '#E09A45' } }
    datetime: {|| (date now) - $in
    | if $in < 1hr {
      {fg: '#E05A38', attr: 'b'}
    } else if $in < 6hr {
      '#E05A38'
    } else if $in < 1day {
      '#F2B865'
    } else if $in < 3day {
      '#A9AC6E'
    } else if $in < 1wk {
      {fg: '#A9AC6E', attr: 'b'}
    } else if $in < 6wk {
      '#8FA79C'
    } else if $in < 52wk {
      '#7B8A94'
    } else { 'dark_gray' } }
    filesize: {|e|
      if $e == 0b {
        '#CBB699'
      } else if $e < 1mb {
        '#8FA79C'
      } else {{fg: '#F0873F'}}
    }
    shape_and: {fg: '#B5697A', attr: 'b'}
    shape_binary: {fg: '#B5697A', attr: 'b'}
    shape_block: {fg: '#7B8A94', attr: 'b'}
    shape_bool: '#A9C0B4'
    shape_closure: {fg: '#8FA79C', attr: 'b'}
    shape_custom: '#A9AC6E'
    shape_datetime: {fg: '#8FA79C', attr: 'b'}
    shape_directory: '#F0873F'
    shape_external: '#E8A05A'
    shape_external_resolved: '#F2B865'
    shape_externalarg: {fg: '#A9AC6E', attr: 'b'}
    shape_filepath: '#E8A05A'
    shape_flag: {fg: '#98A8B2', attr: 'b'}
    shape_float: {fg: '#E05A38', attr: 'b'}
    shape_garbage: {fg: '#F0E2C9', bg: '#C4432C', attr: 'b'}
    shape_glob_interpolation: {fg: '#8FA79C', attr: 'b'}
    shape_globpattern: {fg: '#8FA79C', attr: 'b'}
    shape_int: {fg: '#CE8895', attr: 'b'}
    shape_internalcall: {fg: '#F0873F', attr: 'b'}
    shape_keyword: {fg: '#E05A38', attr: 'b'}
    shape_list: {fg: '#8FA79C', attr: 'b'}
    shape_literal: '#7B8A94'
    shape_match_pattern: '#A9AC6E'
    shape_matching_brackets: {attr: 'u'}
    shape_nothing: '#C4432C'
    shape_operator: '#E09A45'
    shape_or: {fg: '#B5697A', attr: 'b'}
    shape_pipe: {fg: '#E0673A', attr: 'b'}
    shape_range: {fg: '#E09A45', attr: 'b'}
    shape_raw_string: {fg: '#CBB699', attr: 'b'}
    shape_record: {fg: '#8FA79C', attr: 'b'}
    shape_redirection: {fg: '#CE8895', attr: 'b'}
    shape_signature: {fg: '#A9AC6E', attr: 'b'}
    shape_string: '#A9AC6E'
    shape_string_interpolation: {fg: '#8FA79C', attr: 'b'}
    shape_table: {fg: '#7B8A94', attr: 'b'}
    shape_vardecl: {fg: '#F2B865', attr: 'u'}
    shape_variable: '#F2B865'
    foreground: '#E4D3B8'
    background: '#160F0D'
    cursor: '#F0873F'
    empty: '#7B8A94'
    header: {fg: '#F0873F', attr: 'b'}
    hints: '#584038'
    leading_trailing_space_bg: {attr: 'n'}
    row_index: {fg: '#E09A45', attr: 'b'}
    search_result: {fg: '#160F0D', bg: '#F0873F'}
    separator: '#584038'
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

use activate
