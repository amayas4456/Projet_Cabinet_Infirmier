<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:med="http://www.univ-grenoble-alpes.fr/l3miage/medical"
                xmlns:act="http://www.univ-grenoble-alpes.fr/l3miage/actes"
                exclude-result-prefixes="med act">

    <!-- Paramètre global pour spécifier l'ID de l'infirmier -->
    <xsl:param name="infirmierId" select="'001'"/>

    <!-- Charger le document actes.xml -->
    <xsl:variable name="actes" select="document('actes.xml')/act:ngap/act:actes/act:acte"/>

    <!-- Template principal -->
    <xsl:template match="/med:Cabinet">
        <html>
            <head>
                <title>Page de l'Infirmier</title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    background-color: #f5f5f5;
                    margin: 0;
                    padding: 0;
                    }
                    .header {
                    background-color: #4CAF50;
                    color: white;
                    padding: 10px;
                    text-align: center;
                    }
                    .content {
                    padding: 20px;
                    }
                    .patient {
                    margin: 10px 0;
                    padding: 10px;
                    background-color: #fff;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    }
                    ul {
                    padding-left: 20px;
                    }
                    li {
                    margin-bottom: 5px;
                    }
                </style>
            </head>
            <body>
                <!-- En-tête -->
                <div class="header">
                    <h1>Bonjour, <xsl:value-of select="med:infirmiers/med:infirmier[@id = $infirmierId]/med:prenom"/></h1>
                    <p>Vous avez <xsl:value-of select="count(med:patients/med:patient[med:visites/med:Visite/med:intervenant = $infirmierId])"/> patients à visiter aujourd'hui.</p>
                </div>

                <!-- Liste des patients -->
                <div class="content">
                    <xsl:for-each select="med:patients/med:patient[med:visites/med:Visite/med:intervenant = $infirmierId]">
                        <div class="patient">
                            <h2><xsl:value-of select="med:nom"/> <xsl:value-of select="med:prenom"/></h2>
                            <p>Adresse : <xsl:value-of select="med:adresse/med:rue"/>, <xsl:value-of select="med:adresse/med:ville"/> (<xsl:value-of select="med:adresse/med:codePostal"/>)</p>
                            <p><strong>Soins à effectuer :</strong></p>
                            <ul>
                                <xsl:for-each select="med:visites/med:Visite/med:actes/med:acte">
                                    <li>
                                        <xsl:value-of select="$actes[@id = current()/@id]"/>
                                        (Type: <xsl:value-of select="@type"/>, Clé: <xsl:value-of select="@cle"/>, Coef: <xsl:value-of select="@coef"/>)
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
