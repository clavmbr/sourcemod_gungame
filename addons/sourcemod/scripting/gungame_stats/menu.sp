// threaded
DisplayTopMenu(client)
{
    new offset, itemsOnPage = 10;
    offset = ClientOnPage[client] * itemsOnPage;

    if ( ( offset < 0 ) || ( offset >= TotalWinners ) ) {
        offset = 0;
        ClientOnPage[client] = 0;
    }
    decl String:query[1024];
    Format(query, sizeof(query), g_sql_getTopPlayers, itemsOnPage, offset);
    #if defined SQL_DEBUG
        LogError("[DEBUG-SQL] %s", query);
    #endif
    SQL_TQuery(g_DbConnection, T_DisplayTopMenu, query, client);
}

public T_DisplayTopMenu(Handle:owner, Handle:result, const String:error[], any:client)
{
    if ( !IsClientConnected(client) )
    {
        return;
    }
    if ( result == INVALID_HANDLE )
    {
        LogError("Failed to retrieve top players (error: %s)", error);
        return;
    }

    new offset, itemsOnPage = 10;
    offset = ClientOnPage[client] * itemsOnPage;

    if ( ( offset < 0 ) || ( offset >= TotalWinners ) ) {
        offset = 0;
        ClientOnPage[client] = 0;
    }

    new end, pages;
    end = offset + itemsOnPage;
    if ( end > TotalWinners ) {
        end = TotalWinners;
    }
    pages = RoundToCeil(Float:TotalWinners/Float:itemsOnPage);

    SetGlobalTransTarget(client);
    decl String:text[256];

    new Handle:menu = CreatePanel();

    if ( TotalWinners )
    {
        Format(text, sizeof(text), "%t", "TopPanel: Top", offset + 1, end, TotalWinners);
        SetPanelTitle(menu, text);
        DrawPanelText(menu, BLANK_SPACE);

        Format(text, sizeof(text), "%t", "Panel: Page", ClientOnPage[client] + 1, pages);
        DrawPanelText(menu, text);
        DrawPanelText(menu, BLANK_SPACE);

        new i = offset;
        decl String:name[MAX_NAME_SIZE], String:subtext[64];
        new wins;
        while ( SQL_FetchRow(result) )
        {
            wins = SQL_FetchInt(result, 1);
            SQL_FetchString(result, 2, name, sizeof(name));
            FormatLanguageNumberTextEx(client, subtext, sizeof(subtext), wins, "wins");
            if ( ++i < 4 )
            {
                Format(text, sizeof(text), "%t", "TopPanel: Name Wins", name, subtext);
                DrawPanelItem(menu, text);
            }
            else
            {
                Format(text, sizeof(text), "%t", "TopPanel: Place Name Wins", i, name, subtext);
                DrawPanelText(menu, text);
            }
        }
    }
    else
    {
        Format(text, sizeof(text), "%t", "TopPanel: Top short");
        SetPanelTitle(menu, text);
        DrawPanelText(menu, BLANK_SPACE);

        Format(text, sizeof(text), "%t", "TopPanel: There are currently no players in the top");
        DrawPanelItem(menu, text);
    }

    DrawPanelText(menu, BLANK_SPACE);
    SetPanelCurrentKey(menu, 8);

    if ( offset == 0 ) {
        SetPanelCurrentKey(menu, 9);
    } else {
        Format(text, sizeof(text), "%t", "Panel: Back");
        DrawPanelItem(menu, text, ITEMDRAW_CONTROL);
    }
    if ( end == TotalWinners ) {
        SetPanelCurrentKey(menu, 10);
    } else {
        Format(text, sizeof(text), "%t", "Panel: Next");
        DrawPanelItem(menu, text, ITEMDRAW_CONTROL);
    }
    Format(text, sizeof(text), "%t", "Panel: Exit");
    DrawPanelItem(menu, text, ITEMDRAW_CONTROL);

    SendPanelToClient(menu, client, TopMenuHandler, GUNGAME_MENU_TIME);
    CloseHandle(menu);
}

public TopMenuHandler(Handle:menu, MenuAction:action, client, param2)
{
    if ( action == MenuAction_Select )
    {
        switch(param2)
        {
            case 8:
            {
                --ClientOnPage[client];
                DisplayTopMenu(client);
            }
            case 9:
            {
                ++ClientOnPage[client];
                DisplayTopMenu(client);
            }
        }
    }
}


ShowTopMenu(client)
{
    ClientOnPage[client] = 0;
    DisplayTopMenu(client);
}

//Looser Menu

// threaded
DisplayBotMenu(client)
{
    new offset, itemsOnPage = 10;
    offset = ClientOnPage[client] * itemsOnPage;

    if ( ( offset < 0 ) || ( offset >= TotalLoosers ) ) {
        offset = 0;
        ClientOnPage[client] = 0;
    }
    decl String:query[1024];
    Format(query, sizeof(query), g_sql_getBotPlayers, itemsOnPage, offset);
    #if defined SQL_DEBUG
        LogError("[DEBUG-SQL] %s", query);
    #endif
    SQL_TQuery(g_DbConnection, T_DisplayBotMenu, query, client);
}

public T_DisplayBotMenu(Handle:owner, Handle:result, const String:error[], any:client)
{
    if ( !IsClientConnected(client) )
    {
        return;
    }
    if ( result == INVALID_HANDLE )
    {
        LogError("Failed to retrieve bot players (error: %s)", error);
        return;
    }

    new offset, itemsOnPage = 10;
    offset = ClientOnPage[client] * itemsOnPage;

    if ( ( offset < 0 ) || ( offset >= TotalLoosers ) ) {
        offset = 0;
        ClientOnPage[client] = 0;
    }

    new end, pages;
    end = offset + itemsOnPage;
    if ( end > TotalLoosers ) {
        end = TotalLoosers;
    }
    pages = RoundToCeil(Float:TotalLoosers/Float:itemsOnPage);

    SetGlobalTransTarget(client);
    decl String:text[256];

    new Handle:menu = CreatePanel();

    if ( TotalLoosers )
    {
        Format(text, sizeof(text), "%t", "BotPanel: Bot", offset + 1, end, TotalLoosers);
        SetPanelTitle(menu, text);
        DrawPanelText(menu, BLANK_SPACE);

        Format(text, sizeof(text), "%t", "Panel: Page", ClientOnPage[client] + 1, pages);
        DrawPanelText(menu, text);
        DrawPanelText(menu, BLANK_SPACE);

        new i = offset;
        decl String:name[MAX_NAME_SIZE], String:subtext[64];
        new looses;
        while ( SQL_FetchRow(result) )
        {
            looses = SQL_FetchInt(result, 1);
            SQL_FetchString(result, 2, name, sizeof(name));
            FormatLanguageNumberTextEx(client, subtext, sizeof(subtext), looses, "looses");
            if ( ++i < 4 )
            {
                Format(text, sizeof(text), "%t", "TopPanel: Name Wins", name, subtext);
                DrawPanelItem(menu, text);
            }
            else
            {
                Format(text, sizeof(text), "%t", "TopPanel: Place Name Wins", i, name, subtext);
                DrawPanelText(menu, text);
            }
        }
    }
    else
    {
        Format(text, sizeof(text), "%t", "BotPanel: Bot short");
        SetPanelTitle(menu, text);
        DrawPanelText(menu, BLANK_SPACE);

        Format(text, sizeof(text), "%t", "BotPanel: There are currently no players in the bot");
        DrawPanelItem(menu, text);
    }

    DrawPanelText(menu, BLANK_SPACE);
    SetPanelCurrentKey(menu, 8);

    if ( offset == 0 ) {
        SetPanelCurrentKey(menu, 9);
    } else {
        Format(text, sizeof(text), "%t", "Panel: Back");
        DrawPanelItem(menu, text, ITEMDRAW_CONTROL);
    }
    if ( end == TotalLoosers ) {
        SetPanelCurrentKey(menu, 10);
    } else {
        Format(text, sizeof(text), "%t", "Panel: Next");
        DrawPanelItem(menu, text, ITEMDRAW_CONTROL);
    }
    Format(text, sizeof(text), "%t", "Panel: Exit");
    DrawPanelItem(menu, text, ITEMDRAW_CONTROL);

    SendPanelToClient(menu, client, BotMenuHandler, GUNGAME_MENU_TIME);
    CloseHandle(menu);
}

public BotMenuHandler(Handle:menu, MenuAction:action, client, param2)
{
    if ( action == MenuAction_Select )
    {
        switch(param2)
        {
            case 8:
            {
                --ClientOnPage[client];
                DisplayBotMenu(client);
            }
            case 9:
            {
                ++ClientOnPage[client];
                DisplayBotMenu(client);
            }
        }
    }
}


ShowBotMenu(client)
{
    ClientOnPage[client] = 0;
    DisplayBotMenu(client);
}
