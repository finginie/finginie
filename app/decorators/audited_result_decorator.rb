class AuditedResultDecorator < ApplicationDecorator
  decorates :audited_result

  BANKING_BALANCE_SHEET = [
    { :title => 'Authorised Capital',                     :heading => true,  :field_name => 'authorised_capital'          },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Sources Of Fund',                        :heading => true                                                },
    { :title => 'Equity Share Capital',                   :heading => false, :field_name => 'equity_capital'              },
    { :title => 'Share Application Money',                :heading => false, :field_name => 'share_appl_money'            },
    { :title => 'Preference Share Capital',               :heading => false, :field_name => 'pref_capital'                },
    { :title => 'Free Reserves and Surplus',              :heading => false, :field_name => 'free_reservesand_surplus'    },
    { :title => 'Other Reserves',                         :heading => false, :field_name => 'other_reserves'              },
    { :title => 'Reserves & Surplus',                     :heading => false, :field_name => 'resand_surplus'              },
    { :title => 'Net Worth',                              :heading => true,  :field_name => 'net_worth'                   },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Loan Funds',                             :heading => true                                                },
    { :title => 'Demand Deposits',                        :heading => false, :field_name => 'demand_deposits'             },
    { :title => 'Savings Deposits',                       :heading => false, :field_name => 'savings_deposits_un_secured' },
    { :title => 'Time Deposits',                          :heading => false, :field_name => 'time_deposits_un_secured'    },
    { :title => 'Total Deposits',                         :heading => false, :field_name => 'unsecured_loans'             },
    { :title => 'Borrowings made by the bank',            :heading => false, :field_name => 'borrowings_by_bank'          },
    { :title => 'Total Liabilities',                      :heading => true,  :field_name => 'total_liabilities'           },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Application Of Funds',                   :heading => true                                                },
    { :title => 'Cash & Balances with RBI',               :heading => false,  :field_name => 'cash_and_bank_balance'      },
    { :title => 'Money at call and Short Notice',         :heading => false,  :field_name => 'money_at_call_short_notice' },
    { :title => 'Investments',                            :heading => false,  :field_name => 'investments'                },
    { :title => 'Advances',                               :heading => false, :field_name => 'advances'                    },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Fixed Assets',                           :heading => true                                                },
    { :title => 'Gross Block',                            :heading => false, :field_name => 'gross_block'                 },
    { :title => 'Less: Revaluation Reserve',              :heading => false, :field_name => 'revaluation_reserve'         },
    { :title => 'Less: Accumulated Depreciation',         :heading => false, :field_name => 'depreciation_on_f_assets'    },
    { :title => 'Net Block',                              :heading => true,  :field_name => 'net_block'                   },
    { :title => 'Capital Work-in-progress',               :heading => false, :field_name => 'capital_wip'                 },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Net Current  Assets',                    :heading => true                                                },
    { :title => 'Current Assets',                         :heading => false, :field_name => 'current_assets'              },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Creditors',                              :heading => false, :field_name => 'sundry_creditors'            },
    { :title => 'Other Current Liabilities',              :heading => false, :field_name => 'other_current_liabilities'   },
    { :title => 'Provisions',                             :heading => false, :field_name => 'total_provisions'            },
    { :title => 'Current Liabilities And Provisions',     :heading => false, :field_name => 'curr_liab_and_prov'          },
    { :title => 'Net Current  Assets',                    :heading => false,  :field_name => 'net_current_assets'         },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Miscellaneous Expenses not written off', :heading => false, :field_name => 'misc_exp_not_w_off'          },
    { :title => 'Total Assets',                           :heading => true,  :field_name => 'total_assets'                },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Note',                                   :heading => true                                                },
    { :title => 'Contingent liabilities',                 :heading => false, :field_name => 'contingent_liabilities'      },
    { :title => 'Book Value of Unquoted Investment',      :heading => false, :field_name => 'book_value'                  },
    { :title => 'Market Value of Quoted Investment',      :heading => false, :field_name => 'market_value'                },
    { :title => 'Deposits in Indian Branches',            :heading => false, :field_name => 'dep_of_ind_branches'         },
    { :title => 'Deposits in Foreign Branches',           :heading => false, :field_name => 'dep_of_forgn_branches'       },
    { :title => 'Number Of Branches',                     :heading => false, :field_name => 'number_of_branches'          },
    { :title => 'Number of Equity Shares (in lakhs)',     :heading => false, :field_name => 'number_of_equity_shares'      }
  ]

  NON_BANKING_BALANCE_SHEET = [
    { :title => 'Authorised Capital',                     :heading => true,  :field_name => 'authorised_capital'          },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Sources Of Fund',                        :heading => true                                                },
    { :title => 'Total Share Capital',                    :heading => false, :field_name => 'total_share_capital'         },
    { :title => 'Equity Share Capital',                   :heading => false, :field_name => 'equity_capital'              },
    { :title => 'Share Application Money',                :heading => false, :field_name => 'share_appl_money'            },
    { :title => 'Preference Share Capital',               :heading => false, :field_name => 'pref_capital'                },
    { :title => 'Free Reserves and Surplus',              :heading => false, :field_name => 'free_reservesand_surplus'    },
    { :title => 'Other Reserves',                         :heading => false, :field_name => 'other_reserves'              },
    { :title => 'Total Reserves & Surplus',               :heading => true,  :field_name => 'resand_surplus'              },
    { :title => 'Revaluation Reserves',                   :heading => false, :field_name => 'revaluation_reserve'         },
    { :title => 'Net Worth',                              :heading => true,  :field_name => 'net_worth'                   },
    { :title => 'Long Term Loans',                        :heading => false, :field_name => 'long_term_loan'              },
    { :title => 'Unsecured Term Loans',                   :heading => false, :field_name => 'unsecured_term_loans'        },
    { :title => 'Total Debt',                             :heading => true,  :field_name => 'total_debt'                  },
    { :title => 'Total Liabilities',                      :heading => true,  :field_name => 'total_liabilities'           },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Application Of Funds',                   :heading => true                                                },
    { :title => 'Gross Block',                            :heading => false, :field_name => 'gross_block'                 },
    { :title => 'Less: Accumulated Depreciation',         :heading => false, :field_name => 'depreciation_on_f_assets'    },
    { :title => 'Net Block',                              :heading => true,  :field_name => 'net_block'                   },
    { :title => 'Capital Work-in-progress',               :heading => false, :field_name => 'capital_wip'                 },
    { :title => 'Investments',                            :heading => false,  :field_name => 'investments'                },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Net Current  Assets',                    :heading => true                                                },
    { :title => 'Cash & Bank Balances',                   :heading => false,  :field_name => 'cash_and_bank_balance'      },
    { :title => 'Receivables',                            :heading => false,  :field_name => 'receivables'                },
    { :title => 'Loans and Advances',                     :heading => false,  :field_name => 'loan_adv'                   },
    { :title => 'Inventory',                              :heading => false, :field_name => 'inventory'                   },
    { :title => 'Total CA, Loans & Advances',             :heading => true, :field_name => 'current_assets'               },
    { :title => 'Creditors',                              :heading => false, :field_name => 'sundry_creditors'            },
    { :title => 'Other Current Liabilities',              :heading => false, :field_name => 'other_current_liabilities'   },
    { :title => 'Provisions',                             :heading => false, :field_name => 'total_provisions'            },
    { :title => 'Current Liabilities And Provisions',     :heading => true,  :field_name => 'curr_liab_and_prov'          },
    { :title => 'Net Current  Assets',                    :heading => true,  :field_name => 'net_current_assets'          },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Miscellaneous Expenses not written off', :heading => false, :field_name => 'misc_exp_not_w_off'          },
    { :title => 'Total Assets',                           :heading => true,  :field_name => 'total_assets'                },
    { :title => '',                                       :heading => false                                               },
    { :title => 'Note',                                   :heading => true                                                },
    { :title => 'Book Value of Unquoted Investment',      :heading => false, :field_name => 'book_value'                  },
    { :title => 'Market Value of Quoted Investment',      :heading => false, :field_name => 'market_value'                },
    { :title => 'Contingent liabilities',                 :heading => false, :field_name => 'contingent_liabilities'      },
    { :title => 'Number of Equity Shares (in lakhs)',     :heading => false, :field_name => 'number_of_equity_shares'      }
  ]

  FIELDS_CRORE = [ 'authorised_capital', 'equity_capital', 'share_appl_money', 'pref_capital', 'free_reservesand_surplus', 'other_reserves', 'resand_surplus',
                   'net_worth', 'long_term_loan', 'unsecured_term_loans', 'total_debt', 'receivables', 'loan_adv', 'inventory', 'total_assets', 'demand_deposits',
                   'savings_deposits_un_secured', 'time_deposits_un_secured', 'unsecured_loans', 'borrowings_by_bank', 'total_liabilities','cash_and_bank_balance',
                   'money_at_call_short_notice', 'investments', 'advances', 'gross_block', 'revaluation_reserve', 'depreciation_on_f_assets','net_block',
                   'capital_wip', 'net_current_assets', 'current_assets', 'sundry_creditors', 'other_current_liabilities', 'total_provisions', 'curr_liab_and_prov',
                   'misc_exp_not_w_off', 'contingent_liabilities', 'book_value', 'market_value', 'dep_of_ind_branches', 'dep_of_forgn_branches' ]

  FIELDS_CRORE.each do |key|
    define_method(key.to_sym) do
      model.send(key.to_sym) ? (model.send(key.to_sym) / 10000000).round(2) : "NA"
    end
  end

  def number_of_equity_shares
    (model.numberof_equity_shares) ? (model.numberof_equity_shares / 100000).round(2) : "NA"
  end

  def balance_sheet_view_items
    return BANKING_BALANCE_SHEET if model.banking_company?
    NON_BANKING_BALANCE_SHEET
  end

  def company_name
    CompanyMaster.where( company_code: model.companycode ).first.company_name
  end
end
