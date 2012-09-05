# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

@question = Question.new :news => "Ace stockbroker Rakesh Jhunjhunwala picks up a  0.08% stake in Axis Bank.",
                :text => "Will the share price of Axis Bank Increase or decrease?",
                :reason => "Rakesh Jhunjhunwala is an ace investor in India and a very popular figure in the investment world.  He has a huge fan following.Many people try to ape his portfolio blindly. Historically, whenever he has bought/ increased his stake in a particular script, the share prices of that company has risen in the short term.
                  Lesson: Stock prices are influenced by a number of factors which sometimes are beyond the technicals and fundamentals of the company.",
                :correct_choice_id => 4,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Axis Bank shares shoot up by 4.3%",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Air India employees' strike enters the 55th day.",
                :text => "Will other airline stocks increase or decrease in price?",
                :reason => "Since Air India employees are on strike, the operations of the airline are bound to suffer. A lot of customers who would have earlier travelled by Air India, would now travel by other airlines like Jet Airways, Spicejet, Go Indigo etc. Hence rival airlines gain at the cost of Air India.Lesson: Share prices of a company are influenced by activities of competitors as well.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Other Airline stocks gain.",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Airport Economic Regulatory Authority (AERA) approves Delhi International Airport Ltd's (DIAL) 345%increase in airport charges. ",
                :text => "Will airline stocks increase or decrease in price?",
                :reason => "Delhi is a major airport hub in India for domestic airlines. A 345% increase in airport charges is bound to increase the travelling costs substantially (by almost Rs 500). A lot of travellers who would have earlier opted to travel by budget airlines like Spicejet, Indigo Airlines and Go Air would now consider shifting to alternate modes of transport like trains and buses. The flight in traffic is from airlines to other modes  is bound to dent airline business. Thus a partial decrease.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Airline stocks fall marginally.",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Airport Economic Regulatory Authority (AERA) approves Delhi International Airport Ltd's (DIAL) 345%increase in airport charges. ",
                :text => "Will airline stocks increase or decrease in price?",
                :reason => "Cotton is a key input in the manufacture of clothes. When prices of inputs rise, the cost of production increases. However companies cannot increase the price of their products so easily as this would hurt sales. Hence, their profit margins would reduce and in turn the share prices reduce.Lesson: Input prices have an impact on the profitabalilty of the company. Thus effecting their share prices.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Grasim shares fall",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Asiant Paints posted a decline of 3% in its net profit at Rs 171.43 crore in the quarter that ended on March 31, 2011 as compared to the corresponding quarter in the previous fiscal.",
                :text => "Will price of Asian Paints increase or decrease?",
                :reason => "More often than not analysts estimate forth coming results and the market forces factor the share price on basis of it. In case the results announced by the company are remarkably different from the analyst estimates, the share prices move sharply based on whether the actual results are better than expected or worse than expected. In case the results are inline with analyst estimates, expect a minimal movement in the price of the share.Lesson: During earnings season, you can expect a sharp movement in the price of a script in case the company announces results that are a starkly different from the analyst estimates.",
                :correct_choice_id => @c.id+3,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Aviation minister hopeful of FDI proposal going ahead. The minister also said that he will discuss  paring tax on aviation turbine fuel which is anything between 4-33% across states",
                :text => "Will  airline stocks increase or decrease in price?",
                :reason => "The news relating to the FDI proposal is very positive for the airline industry. FDI is looked upon as a cheap source of funds. Clubbed with the positive on FDI, the paring off of tax on turbine fuel will reduce the operational costs for airlines. Fuel is a major cost component for airlines and a 4-33% reduction in tax will make a huge difference to its profit and loss statement.Lesson: Access to cheap source  funding is a big positive for any sector/ company. Input prices have an impact on the profitabalilty of the company. Thus effecting their share prices.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Airline stocks gain",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "BHEL has announced that it has won a contract for the electro-mechanical equipment package for a 1,020 megawatts (MW) hydroelectric project in Bhutan. The contract is valued at Rs 950 crore",
                :text => "Will price of BHEL share increase or decrease?",
                :reason => "Winning a huge contract is a positive for the share price of the company. The new orders add to company's existing order book and is looked upon as potential revenue for the company in the coming years.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Increase",
                  },
                  {
                    :text => "Decrease",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "BHEL shares gain",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Brent hovers below $96, not far off from the 17-mth low",
                :text => "Is it a positive for oil marketing companies?",
                :reason => "India imports nearly 70% of its oil requirements. When the international oil prices declines, the cost of procurement for oil marketing companies decrease. Hence it is  positive news for them.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Yes it is",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Brokerages and Banks expect RBI to cut rates by 25-50bps in its mid-quaterly review meeting to be held early next week",
                :text => "Is the news beneficial to the banks?",
                :reason => "The rate referred to here is the repo rate. It the rate at which RBI lends funds to commercial banks. A reduction in the repo rate would mean that commercial banks would be able to access funds at a cheaper rate.",
                :correct_choice_id => @c.id+4,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  },
                  {
                    :text => "Yes it is",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "CCI reports regarding its verdict on accusation on cement companies of cartelisation expected to come out today. Likely penalty to be around 8% of last 3 years revenues if charges are proved",
                :text => "Is the news positive or negative for cement companies?",
                :reason => "The news is a big negative for the cement companies. If CCI finds cement companies guilty, it would impose a fine on the cement companies. While the quantum of fine is unknown and can only be speculated upon, news suggest it is going to huge. Markets usually factor in anticipated news.  The cement companies' share prices are bound to fall in short term. However, in case the CII were to give the cement companies a clean chit and let them go scot free, the share prices of cement companies would rally.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positive",
                  },
                  {
                    :text => "Negative",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "China has announced a slowdown in its GDP growth to 6.25%. It has said that the pressure of slowdown persists and forecasted a growth of 6% for next year",
                :text => "Is the news a positive for Indian share markets?",
                :reason => "China is one of India's major trading partners. In case China slows down, exports to the country would also decrease. In fact China is a major trading partner of a lot European countries and US too. A slowdown in China would spell a slowdown in the exports of many other countries as well. Markets look at indicators of major countries to get a sense of the level of economic activity.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Cognizant Technology Solutions Corp has revised its 2013 guidance downwards by nearly $200 million (around Rs 1,066 crore), due to a slower than anticipated acceleration in demand",
                :text => "Is this a postive news for major players IT players like TCS, Infosys and WIPRO?",
                :reason => "Cognizant has lowered its estimates on back of 'slower than anticipated acceleration in demand'. Such a news is not only a reflection of a slowdown in Cognizant's activities in the coming years but also in the industry as such and is bound to effect other operators in industry negatively.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Cairn Energy, parent company of Cairn India offloads 66.8 million shares to instituional shareholders.",
                :text => "Is this  positive news for Crain Energy?",
                :reason => "Whenever promoters (or parent companies) of a firm sell their stake in the firm, it is looked upon as a negative sign. On the contrary, when a company decides to buy back its shares or promoters increase their stake in the firm, the same is looked upon as a positive sign.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Delhi Electricity Regulatory Commission (DERC) approves a 20.8% hike in electricity tariffs. Reliance Infrastructure and Tata Power operate in the Delhi region.",
                :text => "Is this a good news for Reliance Infra and Tata Power",
                :reason => "Reliance Infra and Tata Power are expected to benefit from the news. Increased tariffs would mean more revenue for the firms at the same cost, thus improving their profitability. ",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "DLF Hotel Holdings Limited, has divested its entire shareholding in Adone Hotels and Hospitality Limitedfor
                 Rs. 567 Crores. The above transaction is in line with the DLF's stated objective of divesting its non-strategic assets",
                :text => "Is this a positive news for DLF?",
                :reason => "As the news suggests 'DLF has stated divesting its non-strategic assets as one of its objectives'. The transaction reflects the management commitment towards its objectives and is thus a positive for DLF shares.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "DoT slaps a penalty on 5 telecom companies for under reporting revenues. Bharati, Vodafone, Reliance Comm, Tata Tele and Idea Cellular among those affected.",
                :text => "Is it a negative for telecom shares?",
                :reason => "Not only will telecom companies suffer because of  a heafty penalty that would have to be paid, but such practices also result in the tarnishing of the image of the companies and in this case the industry. What it really reflects is that all the operators worked hand-in-hand to fabricate their revenues. Such practices usually drive investors away because of the fall in credibility.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Dr Reddy and Merck to jointly develop biosimilars. Biosimilars are generic and low-cost equivalents of proprietary biopharmaceutical products.",
                :text => "How will this news effect shares of industry peers?",
                :reason => "The news pertains only to Dr. Reddy's and would have no effect on its peers.",
                :correct_choice_id => @c.id+3,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "No effect",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Fitch downgrades SBI, 8 more banks to negative. PNB, BOB, Canara Bank, IDBI, ICICI Bank, Axis Bank, Export-Import Bank of India (EXIM) and IDFC amongst those downgraded ",
                :text => "How will the banks be effected?",
                :reason => "When a leading rating agency like S&P, Fitch, Moody / CRISIL downgrade a bank/industry it has 2 major effects:
1) Investors loose faith in the company/ industry and start selling their shares.
2) Some institutions have restrictions on the grade of assets that they can hold in their portfolio. example: They might be mandated to hold shares of only companies which are rated above A. In case such a downgrade results in the rating falling below the prescribed rating, institutions would be forced to sell shares which would lead to a fall in share prices.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "No effect",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Government takes strict measures to cut down on distribution of spurious medicines",
                :text => "Is the news beneficial to the pharamaceutical companies?",
                :reason => "Many local companies indulge in activity of manufacturing spurious medicines and flooding the market with them. These medicines are available at a much cheaper prices compared to the originals. More often than not customers are ignorant about the fakes and end up opting for the cheaper version. Thus the distribution of spurious medicines affects the sales of main stream pharma companies like Dr. Reddy's, Cipla etc. A check on the distribution of spurious medicines is likely to improve the sales and profitability of these companies.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Government is mulling a proposal to increase prices of diesel and cooking gas",
                :text => "Is it beneficial for oil marketing companies (OMCs)?",
                :reason => "Prices of diesel and cooking gas are controlled by the government. Historically, oil marketing companies have forced to sell them at prices below their procurement cost which has lead to substantial losses due to under-recoveries. An increase in price of diesel and cooking gas would help curb these under- recoveries thus helping the OMCs cut their losses.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }

                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "HSBC considers selling its stake in Axis Bank and Yes Bank",
                :text => "Is this news beneficial for Axis Bank and Yes Bank?",
                :reason => "Institutional investors are looked upon as value investors, i.e. they invest in companies for a long period of time to derive value from them. When they liquidate their stake in a company, markets usually sense that the company is trading at its fair value or that there are relatively better opportunities avaliable. Either ways, this is looked upon as a negative sign in the short term and shares prices usually correct.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Idea cellular has announced that under the current economic scenario, it is finding it extremely tough to arrange for the repayment of $145 million FCCB due next month. The converstion price of bonds pegged at inception was Rs 142 per share (Current market price (CMP) = 79.25)",
                :text => "How will the news effect Idea Cellular?",
                :reason => "",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }

                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "In an unexpected turn of events RBI increases CRR ratio by 50 bps",
                :text => "Is this news beneficial for banks?",
                :reason => "CRR stands Cash reserve ratio. It is the percentage of deposits that the commercial banks are required to keep as a reserve with the central bank.When the central bank raises CRR, the funds available with commercial banks decrease thus hampering the banks ability to disburse loans. The slowdown in activity would lead to profits shrinking. Thus banking counters would react negatively to a hike in CRR.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "In wake of mining scam, government has imposed a ban on iron-ore mining in Karnataka, Andhra Pradesh and Goa",
                :text => "Will it effect Tata steel?",
                :reason => "Iron-ore is a used as a major input in making steel. Tata Steel procures most of its iron-ore Jharkand and Orissa. Thus its operations would not be effected by the ban. However JSW Steel, procures its iron ore from Goa. The ban of mining in Goa is bound to effect JSW Steel's production as it would have to procure iron-ore from else where which could lead to  a delay in procurement or/and be forced to pay higher than usual price due to shortage of iron-ore. Thus a company may sometimes be effected even though it is not directly related to a problem. ",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }

                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "IRDA slaps a Rs 1.47 crore fine on HDFC Life",
                :text => "Will it effect the price of HDFC?",
                :reason => "Though the penalty is negative news, the quantum - Rs 1.47 crores, is a very small amount for a company like HDFC.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Jan-March current account gap triples. Surging imports and moderate export growth pushed up the trade deficit",
                :text => "Is this beneficial for the share markets?",
                :reason => "In general, India is a net importer (its imports are greater than its exports). No country would like to import more than it exports, because the net effect would result in its foreign currency reserves depleting. Given the above context, the news says that for the Jan-March quarter India's net imports have grown at a rate faster than its exports.This would results in greater erosion of reserves. Thus it is looked upon negatively. A widening current account deficit
                 (Import - Export) results in depreciation of currency. The share markets would react negatively to such news.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "JSW Steel redeems FCCBs worth Rs 1,573 crores",
                :text => "Is this beneficial to JSW Steel?",
                :reason => "FCCBs stand for Foreign Currency Convertible Bonds. It is an arrangement in which a company issues bonds with an understanding that upon maturity, the bond holders would have an option to either convert their bonds into equity shares of the company or claim the maturity amount. Usually, bond holders exercise the conversion option when the share price of the company is trading above the option price.By redeeming the bonds, not only has JSW Steel avoided dilution of equity but also gained the confidence of the public since the company was able to arrange for pay back.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Kingfisher Airlines has reported that lessors have taken back 34 aircrafts due to non-payment of rentals",
                :text => "How does it effect Jet Airways and Spicejet?",
                :reason => "Following the withdrawals of aircrafts, other airlines stand to gain at the expense of Kingfisher. Post the withdrawal of aircrafts, Kingfisher would be forced to cut down on its operations and ply a lesser number of flights. The flight cancellations would mean that passengers would have to avail the services of other operators in order to reach their desired destination thus driving more revenues for them than originally.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Larsen and Tubro wins a major contract worth Rs 2040 crores",
                :text => "How does it effect share price of Larsen and Tubro?",
                :reason => "Winning a huge contract is a positive for the share price of the company. The new order adds to company's existing order book and is looked upon as potential revenue for the company in the coming years.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Mahindra & Mahindra (M&M) has announced that the board will discuss aproposal for buy-back of its own shares in the forthcoming annual meeting",
                :text => "Is this  good news for shareholders of M&M",
                :reason => "Usually, a company buys back its own shares when it thinks that the shares are available in the market at a substantially lower value that what their fair value should be. Thus a buyback announced by a company is usually looked upon positively.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Maruti Suzuki has reported that its negotiation with its workers has fallen apart. Workers at Maruti Suzuki's  Manesar plant have been on a strike for the past 12 days demanding reinstatement of the 60 permanent workers and 1200 casual workers who were laid off.",
                :text => "How does it effect the share price of Maruti Suzuki?",
                :reason => "Work at Maruti Suzuki's factory has come to a grinding halt because of the strike. The company has not been manufacturing any cars at its Manesar unit because of which the sales of the company are going to take a hit (shortage in supply of the cars due to strike).",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "NTPC awarded 6,370 MW orders in the last six months",
                :text => "How does it effect the share price of NTPC?",
                :reason => "Winning a huge contract is a positive for the share price of the company. The new orders add to the company's existing order book and this is looked upon as potential revenue for the company in the coming years.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Oil companies like BPCL, HPCL and IOC to cut down jet fuel prices by 2%",
                :text => "What is the likely effect on oil marketing companies?",
                :reason => "A reduction in price of jet fuel is going to reduce the margins of OMCs, thus it is looked upon as a negative news.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Oil companies like BPCL, HPCL and IOC to cut down jet fuel prices by 2%",
                :text => "What is the likely effect on airline stocks?",
                :reason => "A reduction in price of jet fuel is going to help airlines curb costs thus improving their  profitability. Thus it is looked upon as a positive news.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "ONGC makes discoveries of 2 new oil wells",
                :text => "How will the share price of ONGC react to the news?",
                :reason => "The newly discovered wells would add to the available resources and help boost the companies output. Thus the stock prices would react positively to the news.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Power Grid raises Rs 4000 crores via bond issue",
                :text => "Is this news beneficial to Power Grid?",
                :reason => "Companies issue bonds as they are generally a cheaper source of funding than bank loans. Also, the fact that the company was able to sell its bonds to investors shows that the market has confidence in the company.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Price of iron-ore falls by 15% in the past month",
                :text => "Will the automobile industry be effected by this news?",
                :reason => "Iron-ore is a used as a major input in making steel. Steel inturn serves as a major input in the manufacturing of cars. A fall in the price of iron-ore would result in a fall in the price of steel which would in turn help reduce the manufaturing costs thus increasing the profitabilty of the firm. Thus the news is beneficial for automobile stocks too.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Reliance Communication raises USD 155m to repay FCCBs",
                :text => "How will shareholders of Reliance Communication react to this news?",
                :reason => "FCCBs stand for Foreign Currency Convertible Bonds. It is an arrangement in which a company issues bonds with an understanding that upon maturity, the bond holders would have an option to either convert their bonds into equity shares of the company or claim the maturity amount. Usually, bond holders exercise the conversion option when the share price of the company is trading above the option price.By redeeming the bonds, not only has JSW Steel avoided dilution of equity but also gained the confidence of the public since the company was able to arrange for pay back.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Reliance Industries (RIL) strikes a $7.2 billion deal with British Petroleum (BP). BP to pick up 30% in 23 oil and gas blocks owned by RIL",
                :text => "Is this beneficial to Releiance Industries?",
                :reason => "BP is  amongst the world largest companies in oil exploration and production. RIL, by striking a deal with BP, has not only raked in a huge pile of cash but also stands to benfit from the technical expertise that the British team would bring along with them. Moreover RIL would also catch the attention of many international investors who would have not been interested in the stock earlier. For all the reasons mentioned above, the share price of RIL is bound to shoot up.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "RIL has announced  that its board has approved the buyback of upto 12 crore fully paid up equity shares of Rs. 10 each at a price not exceeding Rs. 870 per share, payable in cash upto an aggregate amount not exceeding Rs. 10,440 crore from the open market through Stock Exchanges (current market price (CMP) = Rs 850)",
                :text => "Is this beneficial for Reliance Industries stock?",
                :reason => "Though the buyback price is not materially different from its current price, the news is going to be cheered by its investors.Usually a company buys back its own shares when it thinks the shares are available in the market at substantially lower value that what their fair value should be. Thus a buyback announced by a company is usually looked upon positively.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "RIL has reduced its estimates of production from the KG Basin by the D6 block by almost 51% to 193 bcfe",
                :text => "Is this beneficial to Releiance Industries?",
                :reason => "The announcement is going to batter the share price  of the company quite badly. The company has substantially reduced its estimates from one of its key oil blocks and the revised estimates are bound to affect the company financially. Many investors would be scared away because of such a drastic revision. They would also loose faith in the company's management and develop a very conservative view on the guidelines given by the management. The share price of the company is bound to fall. ",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "RIL to reopen petrol pumps in Gujarat. It is going to sell petrol at par with PSUs.",
                :text => "Is this beneficial to Releiance Industries?",
                :reason => "RIL was originally into oil exploration and production. The ability to market and sell its own product is definitely going to add value to RIL's shareholder but the region under consideration is too small to make a material impact on RIL. Thus the news, though welcomed, would have a neglible impact on the company's share price.",
                :correct_choice_id => @c.id+3,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false


@c =Choice.find(:last)
@question = Question.new :news => "Rupee depreciates (falls) by 1% in today's trade and ends at Rs 55.38 per dollar. In the past month, the  Rupee has depreciated by 14% against the dollar",
                :text => "How will share markets react to this?",
                :reason => "A depreciating rupee is bound to hurt our economy. Though a depreciating rupee would increase the value of our exports, it would also increase the value of our imports. India being a net importer (total imports are greater in value than total exports), a rising rupee is going to increase our trade deficit and in turn hurt our economy.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false


@c =Choice.find(:last)
@question = Question.new :news => "The Rupee is trading at 56.05/06 after rising to 55.95, and above its previous close of 56.80/81. The dollar is on course for its biggest quarterly rise versus the rupee in at least 17 years. However, this is also its biggest daily fall since late January",
                :text => "How will share markets react to this?",
                :reason => "A depreciating rupee is bound to hurt our economy. Though a depreciating rupee would increase the value of our exports, it would also increase the value of our imports. India being a net importer (total imports are greater in value than total exports), a rising rupee is going to increase our trade deficit and in turn hurt our economy.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false


@c =Choice.find(:last)
@question = Question.new :news => "SAIL is in negotiatons with trade unions over wage hikes. SAIL has proposed a 8% hike in wages against 35% demanded by unions",
                :text => "How will the news effect share prices of SAIL?",
                :reason => "There are 2 aspects that one needs to consider here.
1) The negotiations are under way. Based on this news nothing can be concluded about the negotiations. It can go either in favour SAIL's management or unions. Taking a position on the basis of either of the circumstances would be mere speculation.
2) One needs to consider what proportion of total expenses are the wage expenses. In the IT industry, wage/salary expenses are usually above 50% of the total expenses. However, in the manufacturing industry, the number is relatively less- around 10%. A wage hike in a company in the IT industry is going to hurt the company more than say a similar wage hike undertaken by  a manufaturing company.",
                :correct_choice_id => @c.id+3,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Speculations are rife that the US Federal Reserve may take more steps to stimulate US economy",
                :text => "What does this mean for our share markets?",
                :reason => "The news is a positive for stock markets across the world. Countries like USA and China dominate the scenario of world trade. An increase in the level of economic activity is bound to benefit other countries too in the hope that steps taken by Federal Reserve would actually help stimulate the US economy, the markets may rise.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Tata Steel has proposed to pay a dividend of Rs 12.00 per stock. The proposal to declare the dividend will be discussed at AGM",
                :text => "Will shareholders of Tata Steel celebrate this news?",
                :reason => "Dividends are looked upon as a sign of healthy business. If a company has a history of paying regular dividends, the amount of dividend it doles out is further looked upon as an indication of the company's financial health. If the company mantains the same level or increases the size of dividend, it is looked upon as a positive sign. If the company reduces the dividend ticket compared to the previous year, it is usually looked upon as a sign of detoriating income and can spell negativity for the stock price. In this case, Tata Steel's dividend  is the same as last year 's and can be looked upon as a healthy sign.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "State-run oil marketing companies are expected to cut petrol prices by Rs 2 per litre at their review meeting today",
                :text => "Is this beneficial for the oil marketing companies?",
                :reason => "Reduced price of petrol would mean reduced margins for the OMCs and thus work against the oil marketing companies.",
                :correct_choice_id => @c.id+2,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Unlisted Honda Motorcycle & Scooter India recently launched 110cc Dream Yuga motorcycle at Rs 44,642 in New Delhi. The company expects to sell 3 lakh units of Dream Yuga motorcycle in the financial year through March 2013",
                :text => "How will share price of 2-wheelers like Bajaj and TVS Motors react to the news?",
                :reason => "The news  is a potential negative for Bajaj and TVS as Honda's new product would add to their competition and threaten to eat into their revenues. However, it is also a potential positive as this could signal strong demand for 2-wheelers in the market. Therefore, we cannot say what the impact of this news will be.",
                :correct_choice_id => @c.id+3,
                :choices_attributes => [
                  {
                    :text => "Positively",
                  },
                  {
                    :text => "Negatively",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]
@q.save false

@c =Choice.find(:last)
@question = Question.new :news => "Wipro has won a multi-million dollar contract from MMG, an Australian unit of China Minmetals Corp",
                :text => "Is this good news for Wipro?",
                :reason => "Winning a huge contract is a positive for the share price of the company. The new order adds to the company's existing order book and is looked upon as potential revenue for the company in the coming years.",
                :correct_choice_id => @c.id+1,
                :choices_attributes => [
                  {
                    :text => "Yes",
                  },
                  {
                    :text => "No",
                  },
                  {
                    :text => "Cannot say",
                  }
                ]