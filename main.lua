--- @since 26.5.6

local M = {}

function M:peek(job)
  local start, cache = os.clock(), ya.file_cache(job)
  if not cache then
    return
  end

  local ok, err = self:preload(job)
  if not ok or err then
    return ya.preview_widget(job, err)
  end

  ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

  local _, err = ya.image_show(cache, job.area)
  ya.preview_widget(job, err)
end

function M:seek() end

function M:preload(job)
  local cache = ya.file_cache(job)
  if not cache or fs.cha(cache) then
    return true
  end

  -- dcat picks the format from the extension, which the cache file lacks. It's
  -- renamed when done, so a preview can't show it half written. The previewer
  -- and preloader can render the same file at once, so each gets its own name.
  local frame = Url(("%s-%d-%d.jpg"):format(tostring(cache), ya.id("app").value, ya.id("ft").value))
  local output, err = Command("dcat")
    :arg({
      "--image",
      tostring(frame),
      "-W",
      rt.preview.max_width,
      "-H",
      rt.preview.max_height,
      "--",
      tostring(job.file.path),
    })
    :stdin(Command.NULL)
    :stdout(Command.NULL)
    :stderr(Command.PIPED)
    :output()

  if not output then
    return true, Err("Failed to start `dcat`, error: %s", err)
  elseif not output.status.success then
    fs.remove("file", frame)
    local message = output.stderr:gsub("^dcat: ", ""):gsub("%s+$", "")
    if message == "" then
      message = "`dcat` exited with error code " .. tostring(output.status.code)
    end
    return false, Err("%s", message)
  end

  local ok, err = fs.rename(frame, cache)
  if not ok then
    return false, Err("Failed to cache the preview: %s", err)
  end
  return true
end

function M:spot(job)
  require("file"):spot(job)
end

return M
