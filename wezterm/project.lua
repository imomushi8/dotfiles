local M = {}

function M.setup(wezterm, config)
  local act = wezterm.action
  local mux = wezterm.mux

  -- Expand ~ to home directory
  local function expand_path(path)
    if path and path:sub(1, 1) == '~' then
      return wezterm.home_dir .. path:sub(2)
    end
    return path
  end

  -- ============================================
  -- Project Workspace System
  -- ============================================
  local projects_dir = wezterm.home_dir .. '/.config/wezterm-projects'

  local function load_projects()
    local projects = {}
    local handle = io.popen('ls -1 "' .. projects_dir .. '"/*.lua 2>/dev/null')
    if handle then
      for file in handle:lines() do
        local name = file:match('([^/]+)%.lua$')
        if name then
          local ok, project = pcall(dofile, file)
          if ok and project and project.workspace then
            project.cwd = expand_path(project.cwd)
            projects[project.workspace] = project
          end
        end
      end
      handle:close()
    end
    return projects
  end

  local function get_active_workspaces()
    local active = {}
    for _, win in ipairs(mux.all_windows()) do
      active[win:get_workspace()] = true
    end
    return active
  end

  local function build_project_choices()
    local projects = load_projects()
    local active = get_active_workspaces()
    local sort_data = {}
    local seen = {}

    for name, project in pairs(projects) do
      seen[name] = true
      local is_active = active[name] and true or false
      local status = is_active and '● ' or '○ '
      table.insert(sort_data, {
        choice = {
          id = 'project:' .. name,
          label = status .. name .. ' (' .. (project.cwd or '?') .. ')',
        },
        is_active = is_active,
      })
    end

    for name, _ in pairs(active) do
      if not seen[name] then
        table.insert(sort_data, {
          choice = {
            id = 'workspace:' .. name,
            label = '● ' .. name .. ' (ad-hoc)',
          },
          is_active = true,
        })
      end
    end

    table.sort(sort_data, function(a, b)
      if a.is_active ~= b.is_active then
        return a.is_active  -- active first
      end
      return a.choice.label < b.choice.label  -- then alphabetical
    end)

    -- Extract choices for InputSelector
    local choices = {}
    for _, item in ipairs(sort_data) do
      table.insert(choices, item.choice)
    end

    return choices, projects
  end

  local function setup_project_tabs(project)
    wezterm.time.call_after(0.3, function()
      local workspace_windows = {}
      for _, win in ipairs(mux.all_windows()) do
        if win:get_workspace() == project.workspace then
          table.insert(workspace_windows, win)
        end
      end

      if #workspace_windows == 0 then return end
      local mux_win = workspace_windows[1]

      local tabs = project.tabs or {}
      for i, tab_config in ipairs(tabs) do
        local tab, pane
        if i == 1 then
          tab = mux_win:active_tab()
          pane = tab:active_pane()
          if project.cwd then
            pane:send_text('cd ' .. project.cwd .. '\n')
          end
        else
          tab, pane = mux_win:spawn_tab { cwd = project.cwd }
          if project.cwd then
            pane:send_text('cd ' .. project.cwd .. '\n')
          end
        end

        if tab_config.cmd then
          pane:send_text(tab_config.cmd .. '\n')
        end
      end

      local first_tab = mux_win:tabs()[1]
      if first_tab then
        first_tab:activate()
      end
    end)
  end

  local function switch_or_start_project(window, pane, id)
    local ws_name = id:match('^workspace:(.+)$')
    if ws_name then
      window:perform_action(act.SwitchToWorkspace { name = ws_name }, pane)
      return
    end

    local name = id:match('^project:(.+)$')
    if not name then return end

    local active = get_active_workspaces()
    local projects = load_projects()
    local project = projects[name]

    if active[name] then
      window:perform_action(act.SwitchToWorkspace { name = name }, pane)
    else
      window:perform_action(
        act.SwitchToWorkspace {
          name = name,
          spawn = { cwd = project and project.cwd or wezterm.home_dir },
        },
        pane
      )

      if project and project.tabs then
        setup_project_tabs(project)
      end
    end
  end

  config.keys = {
    -- Workspace / Project
    { key = 'f', mods = 'LEADER', action = wezterm.action_callback(function(window, pane) -- project launcher
      local choices, _ = build_project_choices()

      if #choices == 0 then
        window:toast_notification('WezTerm', 'No projects found in ' .. projects_dir, nil, 3000)
        return
      end

      window:perform_action(
        act.InputSelector {
          title = 'Switch to Project',
          choices = choices,
          fuzzy = true,
          action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
            if id then
              switch_or_start_project(inner_window, inner_pane, id)
            end
          end),
        },
        pane
      )
    end)},
  }

end

return M
