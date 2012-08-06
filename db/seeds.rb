# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Quiz.create :name => "Investing Behaviour Profile",
            :weight => 0,
            :result_type => "mode",
            :buckets => "Speculator Flocker Meticulous Conservative",
            :questions_attributes => [
              {
                :text => "How much risk would you like to take ?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Not much. I want to play it safe.",
                    :score => 3,
                  },
                  {
                    :text => "I don't mind taking some risk as long as I do my research and know exactly what I am doing.",
                    :score => 2,
                  },
                  {
                    :text => "I will do what most of the others are doing. They can't all be wrong.",
                    :score => 1,
                  },
                  {
                    :text => "Bring it on. I love risk. And that's how I make my money!",
                    :score => 0,
                  }
                ]
              },
              {
                :text => "What is your favorite type of investment?",
                :weight => 4,
                :choices_attributes => [
                  {
                    :text => "Large cap-Stocks or whatever I can easily model.",
                    :score => 2,
                  },
                  {
                    :text => "Small cap stocks and junk bonds. I love my adrenalin!",
                    :score => 0,
                  },
                  {
                    :text => "Government bonds and bank deposits. Better safe than sorry.",
                    :score => 3,
                  },
                  {
                    :text => "Depends on what the analysts and brokers recommend. They know much better than me.",
                    :score => 1,
                  }
                ]
              },
              {
                :text => "You make up your mind to buy a certain stock but just as you are about to place the order, your friend calls you up and mentions that he sold that stock since he is sure that it will go down in value over the next month or so. You",
                :weight => 9,
                :choices_attributes => [
                  {
                    :text => "Go ahead and buy that stock. I did extensive research before coming to my decision and am confident that I am right.",
                    :score => 2
                  },
                  {
                    :text => "Buy a put option on that very stock. What if my friend is right? Perhaps I can make money off it *slurp *.",
                    :score => 0
                  },
                  {
                    :text => "Call off your purchase. I think I should stop buying these shares and buy something safer like high quality corporate bonds",
                    :score => 3
                  },
                  {
                    :text => "Call 2 other friends to see what they have to say about it and then end up short-selling the stock as both of them think it will fall like a stone.",
                    :score => 1
                  }
                ]
              },
              {
                :text => "Would you invest borrowed money/trade using margin?",
                :weight => 6,
                :choices_attributes => [
                  {
                    :text => "Yes! I can make a lot more money that way.",
                    :score => 0
                  },
                  {
                    :text => "No way! I can end up losing more money that I had.",
                    :score => 3
                  },
                  {
                    :text => "Hmm.let me see what the Analysts are saying. I will consider it only if the experts think it is safe.",
                    :score => 1
                  },
                  {
                    :text => "I am not averse to the idea but I need to analyze the effects of borrowing on my investment returns using some equations. I will also need to see the historic returns of investors who borrowed money to invest.",
                    :score => 2
                  }
                ]
              },
              {
                :text => "Who is your favorite investor?",
                :weight => 5,
                :choices_attributes => [
                  {
                    :text => "Warren Buffet. He was methodical and analyzed all this investments.",
                    :score => 2
                  },
                  {
                    :text => "George Soros. He did some crazy stuff, took on lots of risk, even went bankrupt once but is still a billionaire.",
                    :score => 0,
                    :ceiling => 10
                  },
                  {
                    :text => "Not too sure. I don't know much about investors.",
                    :score => 1,
                    :ceiling => 10
                  },
                  {
                    :text => "No one is very good. They all lose money during recessions.",
                    :score => 3,
                    :ceiling => 10
                  }
                ]
              },
              {
                :text => "If your well-diversified portfolio consisting of large cap stocks, ETFs tracking major world indices, investment grade bonds and commodities was down 40% from its beginning of year value, you would: ",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Continue to hold it. I did a lot of research before investing and you are sure that it will give me great returns in the long run.",
                    :score => 2
                  },
                  {
                    :text => "What! Down 40%! I should have stuck to government bonds. But I will just hold this portfolio till it picks up in value. I dont really have a choice, do I?",
                    :score => 3
                  },
                  {
                    :text => "Wait for the time being. I plan to call my friends and see what they are doing. I will also write to Jim Cramer or another TV Investment show host and see what he recommends.",
                    :score => 1
                  },
                  {
                    :text => "Continue to hold it. I will also buy call options on the S&P 500 hoping to profit from an upward move.",
                    :score => 0
                  }
                ]
              },
              {
                :text => "What do you think of the usefulness of stock recommendations made Financial Analysts?",
                :weight => 7,
                :choices_attributes => [
                  {
                    :text => "What stocks? I only invest in government bonds.",
                    :score => 3
                  },
                  {
                    :text => "These Analysts have PHds in Finance and plenty of experience. They surely know what they are talking about.",
                    :score => 1
                  },
                  {
                    :text => "Hmmm... I am skeptical. I would like to do the analysis on my own",
                    :score => 2
                  },
                  {
                    :text => "They are ok as long as I can make a quick buck off them.",
                    :score => 0
                  }
                ]
              },
              {
                :text => "What is your opinion on the statement - 'Taking on lots of risk generally gives high rewards.'?",
                :weight => 8,
                :choices_attributes => [
                  {
                    :text => "In theory yes, but in reality, high risk portfolios generally lose money.",
                    :score => 3
                  },
                  {
                    :text => "True! The entire investment community can't be wrong.",
                    :score => 1
                  },
                  {
                    :text => "True! Hence, I take on loads of risk.",
                    :score => 0
                  },
                  {
                    :text => "Maybe. but I still like to do my research.",
                    :score => 2
                  }
                ]
              },
              {
                :text => "Are you comfortable taking above average risk?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Yes",
                    :score => 0
                  },
                  {
                    :text => "No",
                    :score => 3
                  }
                ]
              },
              {
                :text => "Do you believe that, for whatever reason, you can do a better job of investing your own",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Yes",
                    :score => 2
                  },
                  {
                    :text => "No",
                    :score => 1
                  },
                  {
                    :text => "Not sure",
                    :score => 0
                  }
                ]
              }
            ]

Quiz.create :name => "Emotional Risk Appetite",
            :weight => 35,
            :result_type => "mean",
            :questions_attributes => [
              {
                :text => "You have invested half of your life's savings in a diversified set of high quality stocks but the market crashes, reducing the value of your investments by 25%. You: ",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Invest more money into the same basket of stocks. These are fundamentally strong companies and dips are great buying opportunities.",
                    :score => 10
                  },
                  {
                    :text => "Continue to hold your investments. The fall is temporary and the prices will eventually go up again.",
                    :score => 7
                  },
                  {
                    :text => "Sell half of your holdings. Gosh! I don't like the looks of this.",
                    :score => 4
                  },
                  {
                    :text => "Sell all your holdings.",
                    :score => 1
                  }
                ]
              },
              {
                :text => "If you had invested 2 times your monthly salary in a basket of stocks and were told 6 months later that the value of the stocks had fallen by 30% but that the top investing gurus think that they are very likely to appreciate substantially in value over a 2 year period, how uncomfortable would you be: ",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Not uncomfortable at all. Ups and downs are part of the game.",
                    :score => 10
                  },
                  {
                    :text => "Concerned. But hey! No risk, no reward. ",
                    :score => 8
                  },
                  {
                    :text => "Troubled. Who exactly recommended these investments to me?",
                    :score => 4
                  },
                  {
                    :text => "Worried sick. I haven't slept all week. ",
                    :score => 1
                  }
                ]
              },
              {
                :text => "If you were given 1 million US$ and could only do one of the following with the entire amount, what would you do?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Head to Vegas and gamble. I can turn 1 million into 5 million!",
                    :score => 10
                  },
                  {
                    :text => "Invest in stocks. Risky but great return.",
                    :score => 8
                  },
                  {
                    :text => "Invest in corporate bonds. Much safer option.",
                    :score => 5
                  },
                  {
                    :text => "Keep it safe in a bank. What if there is a financial crisis?",
                    :score => 1
                  }
                ]
              },
              {
                :text => "Would you invest in risky securities if they offered much better returns than safer investments?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "No way! I might lose money.",
                    :score => 1,
                    :ceiling => 10
                  },
                  {
                    :text => "Hmmm... I will consider the case.",
                    :score => 4,
                    :ceiling => 10
                  },
                  {
                    :text => "Maybe I will invest half of my money in them and the rest in safe instruments.",
                    :score => 6,
                    :ceiling => 10
                  },
                  {
                    :text => "Yeah! Nothing ventured, nothing gained.",
                    :score => 10,
                    :ceiling => 10
                  }
                ]
              },
              {
                :text => "Is investment risk a significant source of worry for you?Do you lose sleep over the returns from your investments?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "No, I regularly invest in risky assets and am fine with that.",
                    :score => 10
                  },
                  {
                    :text => "I do sometimes worry about my investment but not very often.",
                    :score => 7
                  },
                  {
                    :text => "I worry quite often about my investments.",
                    :score => 5
                  },
                  {
                    :text => "I cannot ever imagine anything other than saving my money in a safe bank deposit with virtually no risk.",
                    :score => 1
                  }
                ]
              }
]

Quiz.create :name => "Financial Risk Appetite",
            :weight => 65,
            :result_type => "mean",
            :questions_attributes => [
              {
                :text => "What is your age?",
                :weight => 15,
                :choices_attributes => [
                  {
                    :text => "0 - 30",
                    :score => 10,
                    :ceiling => 10
                  },
                  {
                    :text => "30 - 40",
                    :score => 7,
                    :ceiling => 10
                  },
                  {
                    :text => "40 - 50",
                    :score => 5,
                    :ceiling => 7
                  },
                  {
                    :text => "50+",
                    :score => 3,
                    :ceiling => 6
                  }
                ]
              },
              {
                :text => "For how long do you intend to hold your portfolio?",
                :weight => 8,
                :choices_attributes => [
                  {
                    :text => "less than 6 months",
                    :score => 1
                  },
                  {
                    :text => "6 - 12 months",
                    :score => 5
                  },
                  {
                    :text => "1 - 5 years",
                    :score => 7
                  },
                  {
                    :text => "> 5 years",
                    :score => 10
                  }
                ]
              },
              {
                :text => "If you were laid off today and left without a job, how long could you and your family live off your savings (excluding your retirement savings)?",
                :weight => 15,
                :choices_attributes => [
                  {
                    :text => "Less than 2 months",
                    :score => 1
                  },
                  {
                    :text => "2 - 6 months",
                    :score => 4
                  },
                  {
                    :text => "6 - 12 months",
                    :score => 7
                  },
                  {
                    :text => "Over 12 months",
                    :score => 10
                  }
                ]
              },
              {
                :text => "Do you <em>need</em> your portfolio returns to contribute towards your day to day living expenses?",
                :weight => 15,
                :choices_attributes => [
                  {
                    :text => "Yes",
                    :score => 0
                  },
                  {
                    :text => "No",
                    :score => 10
                  }
                ]
              },
              {
                :text => "How much of your annual living expenses would you need your portfolio to provide you every year?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "0 - 20",
                    :score => 6,
                    :ceiling => 6
                  },
                  {
                    :text => "20 - 40",
                    :score => 5,
                    :ceiling => 5
                  },
                  {
                    :text => "40 - 50",
                    :score => 4,
                    :ceiling => 4
                  },
                  {
                    :text => "50 +",
                    :score => 1,
                    :ceiling => 1
                  }
                ]
              },
              {
                :text => "How much annual return do you realistically expect to earn on your investments (adjusted for inflation- meaning next year's return in this year's dollars)?<BR/>(High return portfolios generally entail high levels of risk)",
                :weight => 8,
                :choices_attributes => [
                  {
                    :text => "0.25 - 2% P.A.",
                    :score => 1,
                    :ceiling => 10
                  },
                  {
                    :text => "2 - 5% P.A.",
                    :score => 4,
                    :ceiling => 10
                  },
                  {
                    :text => "5 - 10% P.A.",
                    :score => 7,
                    :ceiling => 10
                  },
                  {
                    :text => "Greater than 10% P.A.",
                    :score => 10,
                    :ceiling => 10
                  }
                ]
              },
              {
                :text => "How concerned are you about inflation eating into your real investment returns?",
                :weight => 15,
                :choices_attributes => [
                  {
                    :text => "It is not something that I even think about.",
                    :score => 1
                  },
                  {
                    :text => "I think that I am ok on that front.",
                    :score => 4
                  },
                  {
                    :text => "Concerned but not worried.",
                    :score => 7
                  },
                  {
                    :text => "I am seriously concerned.",
                    :score => 10
                  }
                ]
              },
              {
                :text => "Do you have any unique circumstances not addressed here, that prevent you from taking on investment risk? (For most people, the appropriate answer is No)",
                :weight => 15,
                :choices_attributes => [
                  {
                    :text => "No, I have no such constraints.",
                    :score => 0,
                    :ceiling => 10
                  },
                  {
                    :text => "Yes, I cant take on excessive risk.",
                    :score => 0,
                    :ceiling => 7
                  },
                  {
                    :text => "Yes, I can only take on an average amount of risk.",
                    :score => 0,
                    :ceiling => 6
                  },
                  {
                    :text => "Yes, I can only invest in risk free securities.",
                    :score => 0,
                    :ceiling => 1
                  }
                ]
              },
              {
                :text => "Do you plan to use a substantial part of your portfolio to meet a certain important goal within the next 10 years?",
                :weight => 10,
                :choices_attributes => [
                  {
                    :text => "Yes",
                    :score => 0
                  },
                  {
                    :text => "No",
                    :score => 10
                  },
                 ]
              },
              {
                :text => "What percentage of your portfolio do you plan to use for that goal?",
                :weight => 15,
                :choices_attributes => [
                  {
                    :text => "0 - 20",
                    :score => 0,
                    :ceiling => 6
                  },
                  {
                    :text => "20 - 40",
                    :score => 0,
                    :ceiling => 5
                  },
                  {
                    :text => "40 - 50",
                    :score => 0,
                    :ceiling => 4
                  },
                  {
                    :text => "50 +",
                    :score => 0,
                    :ceiling => 1
                  }
                ]
              }
  ]

Step.create([
    {
      :id     => 1,
      :name   => 'Take Personalized financial profile quiz',
      :points => 50
    },
    {
      :id     => 2,
      :name   => 'Sign up',
      :points => 100
    },
    {
      :id     => 3,
      :name   => 'Like Facebook Page',
      :points => 100
    },
    {
      :id     => 4,
      :name   => 'Share Personalized financial profile results on FB',
      :points => 200
    },
    {
      :id     => 5,
      :name   => 'Share Personalized financial profile results on Twitter',
      :points => 200
    },
    {
      :id     => 6,
      :name   => 'Share Personalized financial profile results on Email',
      :points => 500
    },
    {
      :id     => 7,
      :name   => 'Sign up for Trading account',
      :points => 1000
    },
    {
      :id     => 8,
      :name   => 'Every sign up from shared link',
      :points => 200
    },
    {
      :id     => 9,
      :name   => 'Every new trading account up from shared link',
      :points => 1000
    }
  ])