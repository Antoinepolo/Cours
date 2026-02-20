<?php
        $villes = array();
        $villes["nam"] = array("Namur", 110000, "Namur", "fr");
        $villes["bxl"] = array("Bruxelles", 1200000, "Brabant", "fr");
        $villes["anvers"] = array("Antwerpen", 520000, "Antwerpen", "nl");
        $villes["lg"] = array("Liege", 200000, "Liege", "fr");
        $villes["gand"] = array("Gent", 260000, "Oost−Vlaanderen", "nl");

        $key = array_rand($villes);

        $ville_rand = $villes[$key];

        if ($ville_rand[3] == "fr")
                echo $ville_rand[0] . " " . $ville_rand[1] . "<br>";
        else
                echo $ville_rand[2] . "<br>";
?>
