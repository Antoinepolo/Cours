<?php
        $villes = array();
        $villes["nam"] = array("Namur", 110000, "Namur", "fr");
        $villes["bxl"] = array("Bruxelles", 1200000, "Brabant", "fr");
        $villes["anvers"] = array("Antwerpen", 520000, "Antwerpen", "nl");
        $villes["lg"] = array("Liege", 200000, "Liege", "fr");
        $villes["gand"] = array("Gent", 260000, "Oost−Vlaanderen", "nl");
        
        // On créer un tableau pour stockés les correspondances
        $correspondances = array(
                "fr" => "français",
                "nl" => "néerlendais"
                );

        // On a un tableau associatif, donc on doit le parcourir avec une boucle foreach.
        foreach ($villes as $ville) {
                // On ne peut utiliser une \n que dans un terminal, pour un navigateur, on utilisera "<br>"
                echo $ville[0] . " " .$ville[1] . " " . $ville[2] . " " . $correspondances[$ville[3]] . "<br>";
        }
?>
