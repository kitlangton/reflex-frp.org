{-# LANGUAGE DataKinds #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE Rank2Types #-}
module Frontend where

import Common.Route
import Frontend.Footer
import Frontend.Head
import Frontend.Nav
import Frontend.Page.Documentation
import Frontend.Page.Examples
import Frontend.Page.Faq
import Frontend.Page.Home
import Frontend.Page.Tutorials
import Obelisk.Frontend
import Obelisk.Generated.Static
import Obelisk.Route
import Obelisk.Route.Frontend
import Reflex.Dom.Core

frontend :: Frontend (R Route)
frontend = Frontend
  { _frontend_head = pageHead
  , _frontend_body = do
      elClass "div" "header" $ do
        -- Draw the header logo
        (logo, _) <- elAttr' "img" ("class" =: "logo" <> "src" =: static @"img/logo.svg") blank
        -- When the logo is clicked, go to the homepage
        setRoute $ Route_Home :/ () <$ domEvent Click logo
        nav
        subRoute_ $ \case
          Route_Home -> home
          Route_Tutorials -> tutorials
          Route_Examples -> examples
          Route_Documentation -> documentation
          Route_FAQ -> faq
      footer
  }
