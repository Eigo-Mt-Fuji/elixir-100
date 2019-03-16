defmodule P00Test do
  @moduledoc false

  def remove_highlight(message, lvl) do
    Regex.replace(
      ~r/([\']{#{lvl}})(?<=[\']{#{lvl}})(.+)(?=[\']{#{lvl}})([\']{#{lvl}})/s,
      message,
      fn (_, _, item, _) -> item end
    )
  end
  def solve() do

    "5 '''現在の国号'''「'''''グレートブリテン及び北アイルランド連合王国'''''」に''変''更"
    |> remove_highlight(5)
    |> remove_highlight(3)
    |> remove_highlight(2) |> IO.puts

    cleanser = fn (_, key, ope, val) -> key <> ope <> val |> String.replace("\n", " ") end

    "|略名 = イギリス\n|日本語国名 = グレートブリテン及び北アイルランド連合王国\n|公式国名 = {{lang|en|United Kingdom of Great Britain and Northern Ireland}}<ref>英語以外での正式国名:<br/>\n*{{lang|gd|An Rìoghachd Aonaichte na Breatainn Mhòr agus Eirinn mu Thuath}}（[[スコットランド・ゲール語]]）<br/>\n*{{lang|cy|Teyrnas Gyfunol Prydain Fawr a Gogledd Iwerddon}}（[[ウェールズ語]]）<br/>\n*{{lang|ga|Ríocht Aontaithe na Breataine Móire agus Tuaisceart na hÉireann}}（[[アイルランド語]]）<br/>\n*{{lang|kw|An Rywvaneth Unys a Vreten Veur hag Iwerdhon Glédh}}（[[コーンウォール語]]）<br/>\n*{{lang|sco|Unitit Kinrick o Great Breetain an Northren Ireland}}（[[スコットランド語]]）<br/>\n**{{lang|sco|Claught Kängrick o Docht Brätain an Norlin Airlann}}、{{lang|sco|Unitet Kängdom o Great Brittain an Norlin Airlann}}（アルスター・スコットランド語）</ref>\n|国旗画像 = Flag of the United Kingdom.svg\n|国章画像 = [[ファイル:Royal Coat of Arms of the United Kingdom.svg|85px|イギリスの国章]]\n|国章リンク = （[[イギリスの国章|国章]]）\n|標語 = {{lang|fr|Dieu et mon droit}}<br/>（[[フランス語]]:神と私の権利）\n|国歌 = [[女王陛下万歳|神よ女王陛下を守り給え]]\n|位置画像 = Location_UK_EU_Europe_001.svg\n|公用語 = [[英語]]（事実上）\n|首都 = [[ロンドン]]\n|最大都市 = ロンドン\n|元首等肩書 = [[イギリスの君主|女王]]\n|元首等氏名 = [[エリザベス2世]]\n|首相等肩書 = [[イギリスの首相|首相]]\n|首相等氏名 = [[デーヴィッド・キャメロン]]\n|面積順位 = 76\n|面積大きさ = 1 E11\n|面積値 = 244,820\n|水面積率 = 1.3%\n|人口統計年 = 2011\n|人口順位 = 22\n|人口大きさ = 1 E7\n|人口値 = 63,181,775<ref>[http://esa.un.org/unpd/wpp/Excel-Data/population.htm United Nations Department of Economic and Social Affairs>Population Division>Data>Population>Total Population]</ref>\n|人口密度値 = 246\n|GDP統計年元 = 2012\n|GDP値元 = 1兆5478億<ref name=\"imf-statistics-gdp\">[http://www.imf.org/external/pubs/ft/weo/2012/02/weodata/weorept.aspx?pr.x=70&pr.y=13&sy=2010&ey=2012&scsm=1&ssd=1&sort=country&ds=.&br=1&c=112&s=NGDP%2CNGDPD%2CPPPGDP%2CPPPPC&grp=0&a= IMF>Data and Statistics>World Economic Outlook Databases>By Countrise>United Kingdom]</ref>\n|GDP統計年MER = 2012\n|GDP順位MER = 5\n|GDP値MER = 2兆4337億<ref name=\"imf-statistics-gdp\" />\n|GDP統計年 = 2012\n|GDP順位 = 6\n|GDP値 = 2兆3162億<ref name=\"imf-statistics-gdp\" />\n|GDP/人 = 36,727<ref name=\"imf-statistics-gdp\" />\n|建国形態 = 建国\n|確立形態1 = [[イングランド王国]]／[[スコットランド王国]]<br />（両国とも[[連合法 (1707年)|1707年連合法]]まで）\n|確立年月日1 = [[927年]]／[[843年]]\n|確立形態2 = [[グレートブリテン王国]]建国<br />（[[連合法 (1707年)|1707年連合法]]）\n|確立年月日2 = [[1707年]]\n|確立形態3 = [[グレートブリテン及びアイルランド連合王国]]建国<br />（[[連合法 (1800年)|1800年連合法]]）\n|確立年月日3 = [[1801年]]\n|確立形態4 = 現在の国号「'''グレートブリテン及び北アイルランド連合王国'''」に変更\n|確立年月日4 = [[1927年]]\n|通貨 = [[スターリング・ポンド|UKポンド]] (&pound;)\n|通貨コード = GBP\n|時間帯 = ±0\n|夏時間 = +1\n|ISO 3166-1 = GB / GBR\n|ccTLD = [[.uk]] / [[.gb]]<ref>使用は.ukに比べ圧倒的少数。</ref>\n|国際電話番号 = 44\n|注記 = <references />\n"
     |> String.trim_leading("|")
     |> String.trim_trailing("\n")
     |> String.split("\n|")
     |> Enum.map( fn (item) -> "|"<>item end )
     |> Enum.map(fn (item) -> Regex.replace(~r/^(\|.+)(?=\s\=\s)(\s=\s)(.+)$/s, item, &( cleanser.(&1, &2, &3, &4) )) end)
     |> Enum.reduce("", fn (item, acc) -> acc <> item <> "\n" end)
     |> IO.inspect

  end
end
