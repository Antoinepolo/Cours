<?php
        $villes = array();
        $villes["nam"] = array("Namur", 110000, "Namur", "fr");
        $villes["bxl"] = array("Bruxelles", 1200000, "Brabant", "fr");
        $villes["anvers"] = array("Antwerpen", 520000, "Antwerpen", "nl");
        $villes["lg"] = array("Liege", 200000, "Liege", "fr");
        $villes["gand"] = array("Gent", 260000, "Oost−Vlaanderen", "nl");

        foreach ($villes as $ville) {
                if ($ville[1] > 500000)
                        echo $ville[0] . ", " . $ville[1] . " habitants <br>";
        }
?>
