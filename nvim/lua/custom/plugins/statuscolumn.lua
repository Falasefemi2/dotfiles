vim.pack.add {
  'https://github.com/sergei-durkin/statuscoolumn.nvim',
}

require('statuscoolumn').setup {
  number = {
    type = 'hybrid',
  },

  git = {
    enabled = true,
  },

  border = {
    enabled = true,
    text = '│',
  },

  fold = {
    enabled = true,
    text = {
      opened = '',
      closed = '',
      scope = ' ',
    },
  },

  colors = {
    cursorline = { bg = '#383838' },
    number = {
      normal = '#606684',
      accent = '#B9C4F8',
    },

    diagnostics = {
      error = '#FF6188',
      warning = '#FFCA80',
      info = '#A9DC76',
      hint = '#76E3EA',
    },

    git = {
      added = '#A6DA95',
      modified = '#EED4A0',
      removed = '#ED8796',
    },

    git_staged = {
      added = '#5A7C61',
      modified = '#467C7B',
      removed = '#7F605C',
    },
  },
}
