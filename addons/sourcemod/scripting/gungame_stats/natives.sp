OnCreateNatives()
{
    //Winners
    CreateNative("GG_DisplayTop", __DisplayTop);
    CreateNative("GG_GetClientWins", __GetPlayerWins);
    CreateNative("GG_CountPlayersInStat", __CountPlayersInStat);
    CreateNative("GG_GetPlayerPlaceInStat", __GetPlayerPlaceInStat);
    CreateNative("GG_IsPlayerInTopRank", __IsPlayerInTopRank);
    CreateNative("GG_IsPlayerWinsLoaded", __IsPlayerWinsLoaded);
    CreateNative("GG_ShowRank", __ShowRank);
    //Loosers
    CreateNative("GG_DisplayBot", __DisplayBot);
    CreateNative("GG_GetClientLooses", __GetPlayerLooses);
    CreateNative("GG_CountPlayersInLooserStat", __CountPlayersInLooserStat);
    CreateNative("GG_GetPlayerPlaceInLooserStat", __GetPlayerPlaceInLooserStat);
    CreateNative("GG_IsPlayerInBotRank", __IsPlayerInBotRank);
    CreateNative("GG_ShowLooserRank", __ShowLooserRank);
}

public __DisplayTop(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    ShowTopMenu(client);
    return 1;
}

public __ShowRank(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    ShowRank(client);
    return 1;
}

public __GetPlayerPlaceInStat(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return GetPlayerPlaceInStat(client);
}

public __CountPlayersInStat(Handle:plugin, numParams)
{
    return CountPlayersInStat();
}

public __GetPlayerWins(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return PlayerWinsData[client];
}

public __IsPlayerInTopRank(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return IsPlayerInTopRank(client);
}

public __IsPlayerWinsLoaded(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return g_PlayerWinsLoaded[client];
}

// loosers

public __DisplayBot(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    ShowBotMenu(client);
    return 1;
}

public __ShowLooserRank(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    ShowLoosersRank(client);
    return 1;
}

public __GetPlayerPlaceInLooserStat(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return GetPlayerLoosesPlaceInStat(client);
}

public __CountPlayersInLooserStat(Handle:plugin, numParams)
{
    return CountPlayersInLooserStat();
}

public __GetPlayerLooses(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return PlayerLoosesData[client];
}

public __IsPlayerInBotRank(Handle:plugin, numParams)
{
    new client = GetNativeCell(1);

    if(client < 1 || client > MaxClients)
    {
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index [%d]", client);
    } else if(!IsClientInGame(client)) {
        return ThrowNativeError(SP_ERROR_NATIVE, "Client is not currently ingame [%d]", client);
    }

    return IsPlayerInBotRank(client);
}
