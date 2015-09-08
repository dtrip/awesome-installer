
-- tags = {}

tags = {
    names = {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9
    },
    layouts = {
        layouts[2],
        layouts[4],
        layouts[4],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2]
    },
    icons = {
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil
    }
}

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)

    for i, t in ipairs(tags[s]) do
        awful.tag.seticon(tags.icons[i], t)
    end
end
