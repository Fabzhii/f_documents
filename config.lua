Config = {}

Config.Language = 'DE'
Config.Locales = {
    ['DE'] = {
        ['doc_created'] = {'Du hast ein neues Dokument erstellt.', 'success'},
        ['doc_opened'] = {'Du hast ein Dokument geöffnet.', 'info'},
    },
    ['EN'] = {
        ['doc_created'] = {'You have created a new document.', 'success'},
        ['doc_opened'] = {'You have opened a document.', 'info'},
    },
}

Config.Create = {
    header = 'Erstelle ein Dokument',
    choose = 'Dokumentenart',
}

Config.Meta = {
    description = 'Ein Dokument von %s',
}

Config.Documents = {
    {
        id = 'police1',
        name = 'Waffenschein',
        body = {
            {
                type = 'text',
                name = 'Name',
            },
            {
                type = 'date',
                name = 'Geburtsdatum',
            },
            {
                type = 'info',
                name = 'Zusätzliche Informationen',
                lines = 5,
            },
            {
                type = 'sign',
                name = 'Unterschrift',
                presigned = false,
            },
        }
    },
    {
        id = 'medic1',
        name = 'Medizinisches Artest',
        body = {
            {
                type = 'text',
                name = 'Patienten-Name',
            },
            {
                type = 'date',
                name = 'Patienten-Geburtsdatum',
            },
            {
                type = 'info',
                name = 'Medikament',
                lines = 1,
            },
            {
                type = 'info',
                name = 'Grund der Verabreichung',
                lines = 5,
            },
            {
                type = 'date',
                name = 'Gültigkeitsdatum',
            },
            {
                type = 'sign',
                name = 'Unterschrift',
                presigned = false,
            },
        }
    },
}

Config.Notifcation = function(notify)
    local message = notify[1]
    local notify_type = notify[2]
    lib.notify({
        position = 'top-right',
        description = message,
        type = notify_type,
    })
end 

Config.InfoBar = function(info, toggle)
    local message = info[1]
    local notify_type = info[2]
    if toggle then 
        lib.showTextUI(message, {position = 'left-center'})
    else 
        lib.hideTextUI()
    end
end 