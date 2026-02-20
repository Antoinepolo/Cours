<?php
        $villes = array();
        $villes["nam"] = array("Namur", 110000, "Namur", "fr");
        $villes["bxl"] = array("Bruxelles", 1200000, "Brabant", "fr");
        $villes["anvers"] = array("Antwerpen", 520000, "Antwerpen", "nl");
        $villes["lg"] = array("Liege", 200000, "Liege", "fr");
        $villes["gand"] = array("Gent", 260000, "Oost−Vlaanderen", "nl");

        $total_fr = 0;
        $total_nl = 0;

        foreach ($villes as $ville) {
                if ($ville[3] == "fr")
                        $total_fr += $ville[1];
                else
                        $total_nl += $ville[1];
        }

        echo "Total FR : " . $total_fr . "<br>";
        echo "Total NL : " . $total_nl . "<br>";
?>
