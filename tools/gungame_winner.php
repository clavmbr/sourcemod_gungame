<?php

// This is gungame winner motd file that is been shown 
// by gungame_display_winner plugin.

header("Content-type: text/html; charset=utf-8");

function show($varName) {
    if (isset($_GET[$varName])) {
        echo htmlspecialchars($_GET[$varName], ENT_QUOTES, "UTF-8");
    }
}

$close = isset($_GET['close'])? intval($_GET['close']): 0;
if ($close < 1 || $close > 60) {
    $close = 0;
}

?>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Ganhador GunGame </title>
        <?php if ($close) { ?>
        <script type="text/javascript">
            setTimeout('window.close()', <?php echo $close; ?>000);
        </script>
        <?php } ?>
    </head>
<body>
    <b><?php show("winnerName"); ?></b> Ganhou!<hr><br />
    <b><?php show("winnerName"); ?></b> Ganhou o jogo 
        matando <b><?php show("loserName"); ?></b><br /><br />
    <b>Ganhador:</b><br />
    Vitorias: <b><?php show("wins"); ?></b><br />
    Colocação: <b><?php show("place"); ?></b> 
        de <b><?php show("totalPlaces"); ?></b>
    <b>Entregador:</b><br />
    Entregas: <b><?php show("looses"); ?></b><br />
    Colocação: <b><?php show("looserPlace"); ?></b> 
        de <b><?php show("totallooserPlaces"); ?></b>
</body>
</html>
