//
//  Flags.swift
//  Project Order
//
//  Created by William Robinson on 15/08/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createFlagsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Flags", description: "", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    collection.id = "Flags"

    let item1 = ItemModel(name: "🇦🇨 Ascension Island", image: nil) // Ascension Island
    
    let item2 = ItemModel(name: "🇦🇩 Andorra", image: nil) // Andorra
    
    let item3 = ItemModel(name: "🇦🇪 United Arab Emirates", image: nil) // United Arab Emirates
    
    let item4 = ItemModel(name: "🇦🇫 Afghanistan", image: nil) // Afghanistan

    let item5 = ItemModel(name: "🇦🇬 Afghanistan", image: nil) // Antigua & Barbuda
    
    let item6 = ItemModel(name: "🇦🇮 Anguilla", image: nil) // Anguilla

    let item7 = ItemModel(name: "🇦🇱 Albania", image: nil) // Albania

    let item8 = ItemModel(name: "🇦🇲 Armenia", image: nil) //
    
    let item9 = ItemModel(name: "🇦🇴 Angola", image: nil) //
    
    let item10 = ItemModel(name: "🇦🇶 Antarctica", image: nil) //
    
    let item11 = ItemModel(name: "🇦🇷 Argentina", image: nil) //
    
    let item12 = ItemModel(name: "🇦🇸 American Samoa", image: nil) //
    
    let item13 = ItemModel(name: "🇦🇹 Austria", image: nil) //
    
    let item14 = ItemModel(name: "🇦🇺 Australia", image: nil) //
    
    let item15 = ItemModel(name: "🇦🇼 Aruba", image: nil) //
    
    let item16 = ItemModel(name: "🇦🇽 Åland Islands", image: nil)
    
    let item17 = ItemModel(name: "🇦🇿 Azerbaijan", image: nil)
    
    let item18 = ItemModel(name: "🇧🇦 Bosnia & Herzegovina", image: nil)
    
    let item19 = ItemModel(name: "🇧🇧 Barbados", image: nil)
    
    let item20 = ItemModel(name: "🇧🇩 Bangladesh", image: nil)
    
    let item21 = ItemModel(name: "🇧🇪 Belgium", image: nil)
    
    let item22 = ItemModel(name: "🇧🇫 Burkina Faso", image: nil)
    
    let item23 = ItemModel(name: "🇧🇬 Bulgaria", image: nil)
    
    let item24 = ItemModel(name: "🇧🇭 Bahrain", image: nil)
    
    let item25 = ItemModel(name: "🇧🇮 Burundi", image: nil)
    
    let item26 = ItemModel(name: "🇧🇯 Benin", image: nil)
    
    let item27 = ItemModel(name: "🇧🇱 St. Barthélemy", image: nil)
    
    let item28 = ItemModel(name: "🇧🇲 Bermuda", image: nil)
    
    let item29 = ItemModel(name: "🇧🇳 Brunei", image: nil)
    
    let item30 = ItemModel(name: "🇧🇴 Bolivia", image: nil)
    
    let item31 = ItemModel(name: "🇧🇶 Caribbean Netherlands", image: nil)
    
    let item32 = ItemModel(name: "🇧🇷 Brazil", image: nil)
    
    let item33 = ItemModel(name: "🇧🇸 Bahamas", image: nil)
    
    let item34 = ItemModel(name: "🇧🇹 Bhutan", image: nil)
    
    let item35 = ItemModel(name: "🇧🇻 Bouvet Island", image: nil)
    
    let item36 = ItemModel(name: "🇧🇼 Botswana", image: nil)
    
    let item37 = ItemModel(name: "🇧🇾 Belarus", image: nil)
    
    let item38 = ItemModel(name: "🇧🇿 Belize", image: nil)
    
    let item39 = ItemModel(name: "🇨🇦 Canada", image: nil)
    
    let item40 = ItemModel(name: "🇨🇨 Cocos Islands", image: nil)
    
    let item41 = ItemModel(name: "🇨🇩 Congo - Kinshasa", image: nil)
    
    let item42 = ItemModel(name: "🇨🇫 Central African Republic", image: nil)
    
    let item43 = ItemModel(name: "🇨🇬 Congo - Brazzaville", image: nil)
    
    let item44 = ItemModel(name: "🇨🇭 Switzerland", image: nil) // Andorra
    
    let item45 = ItemModel(name: "🇨🇮 Côte D’Ivoire", image: nil) // United Arab Emirates
    
    let item46 = ItemModel(name: "🇨🇰 Cook Islands", image: nil) // Afghanistan
    
    let item47 = ItemModel(name: "🇨🇱 Chile", image: nil) // Antigua & Barbuda
    
    let item48 = ItemModel(name: "🇨🇲 Cameroon", image: nil) // Anguilla
    
    let item49 = ItemModel(name: "🇨🇳 China", image: nil) // Albania
    
    let item50 = ItemModel(name: "🇨🇴 Colombia", image: nil) //

    let item51 = ItemModel(name: "🇨🇵 Clipperton Island", image: nil) // Ascension Island
    
    let item52 = ItemModel(name: "🇨🇷 Costa Rica", image: nil) // Andorra
    
    let item53 = ItemModel(name: "🇨🇺 Cuba", image: nil) // United Arab Emirates
    
    let item54 = ItemModel(name: "🇨🇻 Cape Verde", image: nil) // Afghanistan
    
    let item55 = ItemModel(name: "🇨🇼 Curaçao", image: nil) // Antigua & Barbuda
    
    let item56 = ItemModel(name: "🇨🇽 Christmas Island", image: nil) // Anguilla
    
    let item57 = ItemModel(name: "🇨🇾 Cyprus", image: nil) // Albania
    
    let item58 = ItemModel(name: "🇨🇿 Czech Republic", image: nil) //
    
    let item59 = ItemModel(name: "🇩🇪 Germany", image: nil) //
    
    let item60 = ItemModel(name: "🇩🇬 Diego Garcia", image: nil) //
    
    let item61 = ItemModel(name: "🇩🇯 Djibouti", image: nil) //
    
    let item62 = ItemModel(name: "🇩🇰 Denmark", image: nil) //
    
    let item63 = ItemModel(name: "🇩🇲 Dominica", image: nil) //
    
    let item64 = ItemModel(name: "🇩🇴 Dominican Republic", image: nil) //
    
    let item65 = ItemModel(name: "🇩🇿 Algeria", image: nil) //
    
    let item66 = ItemModel(name: "🇪🇦 Ceuta & Melilla", image: nil) // Andorra
    
    let item67 = ItemModel(name: "🇪🇨 Ecuador", image: nil) // United Arab Emirates
    
    let item68 = ItemModel(name: "🇪🇪 Estonia", image: nil) // Afghanistan
    
    let item69 = ItemModel(name: "🇪🇬 Egypt", image: nil) // Antigua & Barbuda
    
    let item70 = ItemModel(name: "🇪🇭 Western Sahara", image: nil) // Anguilla
    
    let item71 = ItemModel(name: "🇪🇷 Eritrea", image: nil) // Albania
    
    let item72 = ItemModel(name: "🇪🇸 Spain", image: nil) // Ascension Island
    
    let item73 = ItemModel(name: "🇪🇹 Ethiopia", image: nil) // Andorra
    
    let item74 = ItemModel(name: "🇪🇺 European Union", image: nil) // United Arab Emirates
    
    let item75 = ItemModel(name: "🇫🇮 Finland", image: nil) // Afghanistan
    
    let item76 = ItemModel(name: "🇫🇯 Fiji", image: nil) // Antigua & Barbuda
    
    let item77 = ItemModel(name: "🇫🇰 Falkland Islands", image: nil) // Anguilla
    
    let item78 = ItemModel(name: "🇫🇲 Micronesia", image: nil) // Albania
    
    let item79 = ItemModel(name: "🇫🇴 Faroe Islands", image: nil) // Ascension Island
    
    let item80 = ItemModel(name: "🇫🇷 France", image: nil) // Andorra
    
    let item81 = ItemModel(name: "🇬🇦 Gabon", image: nil) // United Arab Emirates
    
    let item82 = ItemModel(name: "🇬🇧 United Kingdom", image: nil) // Afghanistan
    
    let item83 = ItemModel(name: "🇬🇩 Grenada", image: nil) // Antigua & Barbuda
    
    let item84 = ItemModel(name: "🇬🇪 Georgia", image: nil) // Anguilla
    
    let item85 = ItemModel(name: "🇬🇫 French Guiana", image: nil) // Albania
    
    let item86 = ItemModel(name: "🇬🇬 Guernsey", image: nil) // Ascension Island
    
    let item87 = ItemModel(name: "🇬🇭 Ghana", image: nil) // Andorra
    
    let item88 = ItemModel(name: "🇬🇮 Gibraltar", image: nil) // United Arab Emirates
    
    let item89 = ItemModel(name: "🇬🇱 Greenland", image: nil) // Afghanistan
    
    let item90 = ItemModel(name: "🇬🇲 Gambia", image: nil) // Antigua & Barbuda
    
    let item91 = ItemModel(name: "🇬🇳 Guinea", image: nil) // Anguilla
    
    let item92 = ItemModel(name: "🇬🇵 Guadeloupe", image: nil) // Albania
    
    let item93 = ItemModel(name: "🇬🇶 Equatorial Guinea", image: nil) // Ascension Island
    
    let item94 = ItemModel(name: "🇬🇷 Greece", image: nil) // Andorra
    
    let item95 = ItemModel(name: "🇬🇸 South Georgia & South Sandwich Islands", image: nil) // United Arab Emirates
    
    let item96 = ItemModel(name: "🇬🇹 Guatemala", image: nil) // Afghanistan
    
    let item97 = ItemModel(name: "🇬🇺 Guam", image: nil) // Antigua & Barbuda
    
    let item98 = ItemModel(name: "🇬🇼 Guinea-Bissau", image: nil) // Anguilla
    
    let item99 = ItemModel(name: "🇬🇾 Guyana", image: nil) // Albania
    
    let item100 = ItemModel(name: "🇭🇰 Hong Kong", image: nil) //
    
    let item101 = ItemModel(name: "🇭🇲 Heard & McDonald Islands", image: nil) // United Arab Emirates
    
    let item102 = ItemModel(name: "🇭🇳 Honduras", image: nil) // Afghanistan
    
    let item103 = ItemModel(name: "🇭🇷 Croatia", image: nil) // Antigua & Barbuda
    
    let item104 = ItemModel(name: "🇭🇹 Haiti", image: nil) // Anguilla
    
    let item105 = ItemModel(name: "🇭🇺 Hungary", image: nil) // Albania
    
    let item106 = ItemModel(name: "🇮🇨 Canary Islands", image: nil) //
    
    let item107 = ItemModel(name: "🇮🇩 Indonesia", image: nil) //
    
    let item108 = ItemModel(name: "🇮🇪 Ireland", image: nil) //
    
    let item109 = ItemModel(name: "🇮🇱 Israel", image: nil) //
    
    let item110 = ItemModel(name: "🇮🇲 Isle of Man", image: nil) //
    
    let item111 = ItemModel(name: "🇮🇳 India", image: nil) //
    
    let item112 = ItemModel(name: "🇮🇴 British Indian Ocean Territory", image: nil) //
    
    let item113 = ItemModel(name: "🇮🇶 Iraq", image: nil) //
    
    let item114 = ItemModel(name: "🇮🇷 Iran", image: nil) // Andorra
    
    let item115 = ItemModel(name: "🇮🇸 Iceland", image: nil) // United Arab Emirates
    
    let item116 = ItemModel(name: "🇮🇹 Italy", image: nil) // Afghanistan
    
    let item117 = ItemModel(name: "🇯🇪 Jersey", image: nil) // Antigua & Barbuda
    
    let item118 = ItemModel(name: "🇯🇲 Jamaica", image: nil) // Anguilla
    
    let item119 = ItemModel(name: "🇯🇴 Jordan", image: nil) // Albania
    
    let item120 = ItemModel(name: "🇯🇵 Japan", image: nil) // Ascension Island
    
    let item121 = ItemModel(name: "🇰🇪 Kenya", image: nil) // Andorra
    
    let item122 = ItemModel(name: "🇰🇬 Kyrgyzstan", image: nil) // United Arab Emirates
    
    let item123 = ItemModel(name: "🇰🇭 Cambodia", image: nil) // Afghanistan
    
    let item124 = ItemModel(name: "🇰🇮 Kiribati", image: nil) // Antigua & Barbuda
    
    let item125 = ItemModel(name: "🇰🇲 Comoros", image: nil) // Anguilla
    
    let item126 = ItemModel(name: "🇰🇳 St. Kitts & Nevis", image: nil) // Albania
    
    let item127 = ItemModel(name: "🇰🇵 North Korea", image: nil) // Ascension Island
    
    let item128 = ItemModel(name: "🇰🇷 South Korea", image: nil) // Andorra
    
    let item129 = ItemModel(name: "🇰🇼 Kuwait", image: nil)
    
    let item130 = ItemModel(name: "🇰🇾 Cayman Islands", image: nil)
    
    let item131 = ItemModel(name: "🇰🇿 Kazakhstan", image: nil)
    
    let item132 = ItemModel(name: "🇱🇦 Laos", image: nil)
    
    let item133 = ItemModel(name: "🇱🇧 Lebanon", image: nil)
    
    let item134 = ItemModel(name: "🇱🇨 St. Lucia", image: nil)
    
    let item135 = ItemModel(name: "🇱🇮 Liechtenstein", image: nil)
    
    let item136 = ItemModel(name: "🇱🇰 Sri Lanka", image: nil)
    
    let item137 = ItemModel(name: "🇱🇷 Liberia", image: nil)
    
    let item138 = ItemModel(name: "🇱🇸 Lesotho", image: nil)
    
    let item139 = ItemModel(name: "🇱🇹 Lithuania", image: nil)
    
    let item140 = ItemModel(name: "🇱🇺 Luxembourg", image: nil)
    
    let item141 = ItemModel(name: "🇱🇻 Latvia", image: nil)
    
    let item142 = ItemModel(name: "🇱🇾 Libya", image: nil)
    
    let item143 = ItemModel(name: "🇲🇦 Morocco", image: nil)
    
    let item144 = ItemModel(name: "🇲🇨 Monaco", image: nil)
    
    let item145 = ItemModel(name: "🇲🇩 Moldova", image: nil)
    
    let item146 = ItemModel(name: "🇲🇪 Montenegro", image: nil)
    
    let item147 = ItemModel(name: "🇲🇫 St. Martin", image: nil)
    
    let item148 = ItemModel(name: "🇲🇬 Madagascar", image: nil)
    
    let item149 = ItemModel(name: "🇲🇭 Marshall Islands", image: nil)
    
    let item150 = ItemModel(name: "🇲🇰 Macedonia", image: nil)
    
    let item151 = ItemModel(name: "🇲🇱 Mali", image: nil)
    
    let item152 = ItemModel(name: "🇲🇲 Myanmar", image: nil)
    
    let item153 = ItemModel(name: "🇲🇳 Mongolia", image: nil)
    
    let item154 = ItemModel(name: "🇲🇴 Macau", image: nil)
    
    let item155 = ItemModel(name: "🇲🇵 Northern Mariana Islands", image: nil)
    
    let item156 = ItemModel(name: "🇲🇶 Martinique", image: nil)
    
    let item157 = ItemModel(name: "🇲🇷 Mauritania", image: nil)
    
    let item158 = ItemModel(name: "🇲🇸 Montserrat", image: nil)
    
    let item159 = ItemModel(name: "🇲🇹 Malta", image: nil)
    
    let item160 = ItemModel(name: "🇲🇺 Mauritius", image: nil)
    
    let item161 = ItemModel(name: "🇲🇻 Maldives", image: nil)
    
    let item162 = ItemModel(name: "🇲🇼 Malawi", image: nil)
    
    let item163 = ItemModel(name: "🇲🇽 Mexico", image: nil)
    
    let item164 = ItemModel(name: "🇲🇾 Malaysia", image: nil)
    
    let item165 = ItemModel(name: "🇲🇿 Mozambique", image: nil)
    
    let item166 = ItemModel(name: "🇳🇦 Namibia", image: nil)
    
    let item167 = ItemModel(name: "🇳🇨 New Caledonia", image: nil)
    
    let item168 = ItemModel(name: "🇳🇪 Niger", image: nil)
    
    let item169 = ItemModel(name: "🇳🇫 Norfolk Island", image: nil)
    
    let item170 = ItemModel(name: "🇳🇬 Nigeria", image: nil)
    
    let item171 = ItemModel(name: "🇳🇮 Nicaragua", image: nil)
    
    let item172 = ItemModel(name: "🇳🇱 Netherlands", image: nil)
    
    let item173 = ItemModel(name: "🇳🇴 Norway", image: nil)
    
    let item174 = ItemModel(name: "🇳🇵 Nepal", image: nil)
    
    let item175 = ItemModel(name: "🇳🇷 Nauru", image: nil)
    
    let item176 = ItemModel(name: "🇳🇺 Niue", image: nil)
    
    let item177 = ItemModel(name: "🇳🇿 New Zealand", image: nil)
    
    let item178 = ItemModel(name: "🇴🇲 Oman", image: nil)
    
    let item179 = ItemModel(name: "🇵🇦 Panama", image: nil)
    
    let item180 = ItemModel(name: "🇵🇪 Peru", image: nil)
    
    let item181 = ItemModel(name: "🇵🇫 French Polynesia", image: nil)
    
    let item182 = ItemModel(name: "🇵🇬 Papua New Guinea", image: nil)
    
    let item183 = ItemModel(name: "🇵🇭 Philippines", image: nil)
    
    let item184 = ItemModel(name: "🇵🇰 Pakistan", image: nil)
    
    let item185 = ItemModel(name: "🇵🇱 Poland", image: nil)
    
    let item186 = ItemModel(name: "🇵🇲 St. Pierre & Miquelon", image: nil)
    
    let item187 = ItemModel(name: "🇵🇳 Pitcairn Islands", image: nil)
    
    let item188 = ItemModel(name: "🇵🇷 Puerto Rico", image: nil)
    
    let item189 = ItemModel(name: "🇵🇸 Palestinian Territories", image: nil)
    
    let item190 = ItemModel(name: "🇵🇹 Portugal", image: nil)
    
    let item191 = ItemModel(name: "🇵🇼 Palau", image: nil)
    
    let item192 = ItemModel(name: "🇵🇾 Paraguay", image: nil)
    
    let item193 = ItemModel(name: "🇶🇦 Qatar", image: nil)
    
    let item194 = ItemModel(name: "🇷🇪 Réunion", image: nil)
    
    let item195 = ItemModel(name: "🇷🇴 Romania", image: nil)
    
    let item196 = ItemModel(name: "🇷🇸 Serbia", image: nil)
    
    let item197 = ItemModel(name: "🇷🇺 Russia", image: nil)
    
    let item198 = ItemModel(name: "🇷🇼 Rwanda", image: nil)
    
    let item199 = ItemModel(name: "🇸🇦 Saudi Arabia", image: nil)
    
    let item200 = ItemModel(name: "🇸🇧 Solomon Islands", image: nil)
    
    let item201 = ItemModel(name: "🇸🇨 Seychelles", image: nil)
    
    let item202 = ItemModel(name: "🇸🇩 Sudan", image: nil)
    
    let item203 = ItemModel(name: "🇸🇪 Sweden", image: nil)
    
    let item204 = ItemModel(name: "🇸🇬 Singapore", image: nil)
    
    let item205 = ItemModel(name: "🇸🇭 St. Helena", image: nil)
    
    let item206 = ItemModel(name: "🇸🇮 Slovenia", image: nil)
    
    let item207 = ItemModel(name: "🇸🇯 Svalbard & Jan Mayen", image: nil)
    
    let item208 = ItemModel(name: "🇸🇰 Slovakia", image: nil)
    
    let item209 = ItemModel(name: "🇸🇱 Sierra Leone", image: nil)
    
    let item210 = ItemModel(name: "🇸🇲 San Marino", image: nil)
    
    let item211 = ItemModel(name: "🇸🇳 Senegal", image: nil)
    
    let item212 = ItemModel(name: "🇸🇴 Somalia", image: nil)
    
    let item213 = ItemModel(name: "🇸🇷 Suriname", image: nil)
    
    let item214 = ItemModel(name: "🇸🇸 South Sudan", image: nil)
    
    let item215 = ItemModel(name: "🇸🇹 São Tomé & Príncipe", image: nil)
    
    let item216 = ItemModel(name: "🇸🇻 El Salvador", image: nil)
    
    let item217 = ItemModel(name: "🇸🇽 Sint Maarten", image: nil)
    
    let item218 = ItemModel(name: "🇸🇾 Syria", image: nil)
    
    let item219 = ItemModel(name: "🇸🇿 Swaziland", image: nil)
    
    let item220 = ItemModel(name: "🇹🇦 Tristan Da Cunha", image: nil)
    
    let item221 = ItemModel(name: "🇹🇨 Turks & Caicos Islands", image: nil)
    
    let item222 = ItemModel(name: "🇹🇩 Chad", image: nil)
    
    let item223 = ItemModel(name: "🇹🇫 French Southern Territories", image: nil)
    
    let item224 = ItemModel(name: "🇹🇬 Togo", image: nil)
    
    let item225 = ItemModel(name: "🇹🇭 Thailand", image: nil)
    
    let item226 = ItemModel(name: "🇹🇯 Tajikistan", image: nil)
    
    let item227 = ItemModel(name: "🇹🇰 Tokelau", image: nil)
    
    let item228 = ItemModel(name: "🇹🇱 Timor-Leste", image: nil)
    
    let item229 = ItemModel(name: "🇹🇲 Turkmenistan", image: nil)
    
    let item230 = ItemModel(name: "🇹🇳 Tunisia", image: nil)
    
    let item231 = ItemModel(name: "🇹🇴 Tonga", image: nil)
    
    let item232 = ItemModel(name: "🇹🇷 Turkey", image: nil)
    
    let item233 = ItemModel(name: "🇹🇹 Trinidad & Tobago", image: nil)
    
    let item234 = ItemModel(name: "🇹🇻 Tuvalu", image: nil)
    
    let item235 = ItemModel(name: "🇹🇼 Taiwan", image: nil)
    
    let item236 = ItemModel(name: "🇹🇿 Tanzania", image: nil)
    
    let item237 = ItemModel(name: "🇺🇦 Ukraine", image: nil)
    
    let item238 = ItemModel(name: "🇺🇬 Uganda", image: nil)
    
    let item239 = ItemModel(name: "🇺🇲 U.S. Outlying Islands", image: nil)
    
    let item240 = ItemModel(name: "🇺🇸 United States", image: nil)
    
    let item241 = ItemModel(name: "🇺🇾 Uruguay", image: nil)
    
    let item242 = ItemModel(name: "🇺🇿 Uzbekistan", image: nil)
    
    let item243 = ItemModel(name: "🇻🇦 Vatican City", image: nil)
    
    let item244 = ItemModel(name: "🇻🇨 St. Vincent & Grenadines", image: nil)
    
    let item245 = ItemModel(name: "🇻🇪 Venezuela", image: nil)
    
    let item246 = ItemModel(name: "🇻🇬 British Virgin Islands", image: nil)
    
    let item247 = ItemModel(name: "🇻🇮 U.S. Virgin Islands", image: nil)
    
    let item248 = ItemModel(name: "🇻🇳 Vietnam", image: nil)
    
    let item249 = ItemModel(name: "🇻🇺 Vanuatu", image: nil)
    
    let item250 = ItemModel(name: "🇼🇫 Wallis & Futuna", image: nil)
    
    let item251 = ItemModel(name: "🇼🇸 Samoa", image: nil)
    
    let item252 = ItemModel(name: "🇽🇰 Kosovo", image: nil)
    
    let item253 = ItemModel(name: "🇾🇪 Yemen", image: nil)
    
    let item254 = ItemModel(name: "🇾🇹 Mayotte", image: nil)

    let item255 = ItemModel(name: "🇿🇦 South Africa", image: nil)

    let item256 = ItemModel(name: "🇿🇲 Zambia", image: nil)
    
    let item257 = ItemModel(name: "🇿🇼 Zimbabwe", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7, item8, item9,
                        item10, item11, item12, item13, item14, item15, item16, item17, item18, item19,
                        item20, item21, item22, item23, item24, item25, item26, item27, item28, item29,
                        item30, item31, item32, item33, item34, item35, item36, item37, item38, item39,
                        item40, item41, item42, item43, item44, item45, item46, item47, item48, item49,
                        item50, item51, item52, item53, item54, item55, item56, item57, item58, item59,
                        item60, item61, item62, item63, item64, item65, item66, item67, item68, item69,
                        item70, item71, item72, item73, item74, item75, item76, item77, item78, item79,
                        item80, item81, item82, item83, item84, item85, item86, item87, item88, item89,
                        item90, item91, item92, item93, item94, item95, item96, item97, item98, item99,
                        item100, item101, item102, item103, item104, item105, item106, item107, item108, item109,
                        item110, item111, item112, item113, item114, item115, item116, item117, item118, item119,
                        item120, item121, item122, item123, item124, item125, item126, item127, item128, item129,
                        item130, item131, item132, item133, item134, item135, item136, item137, item138, item139,
                        item140, item141, item142, item143, item144, item145, item146, item147, item148, item149,
                        item150, item151, item152, item153, item154, item155, item156, item157, item158, item159,
                        item160, item161, item162, item163, item164, item165, item166, item167, item168, item169,
                        item170, item171, item172, item173, item174, item175, item176, item177, item178, item179,
                        item180, item181, item182, item183, item184, item185, item186, item187, item188, item189,
                        item190, item191, item192, item193, item194, item195, item196, item197, item198, item199,
                        item200, item201, item202, item203, item204, item205, item206, item207, item208, item209,
                        item210, item211, item212, item213, item214, item215, item216, item217, item218, item219,
                        item220, item221, item222, item223, item224, item225, item226, item227, item228, item229,
                        item230, item231, item232, item233, item234, item235, item236, item237, item238, item239,
                        item240, item241, item242, item243, item244, item245, item246, item247, item248, item249,
                        item250, item251, item252, item253, item254, item255, item256, item257]
    
    return collection
}
