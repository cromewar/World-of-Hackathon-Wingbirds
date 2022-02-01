import React, { useState } from "react";
import tw from "twin.macro";
import styled from "styled-components";
import { css } from "styled-components/macro"; //eslint-disable-line
import { GameFrame } from "components/game/GameFrame.js";
// import { Modal } from 'antd'



import Header, { NavLink, NavLinks, PrimaryLink, LogoLink, NavToggle, DesktopNavLinks } from "../headers/light.js";
import ResponsiveVideoEmbed from "../../helpers/ResponsiveVideoEmbed.js";

const StyledHeader = styled(Header)`
  ${tw`pt-8 max-w-none`}
  ${DesktopNavLinks} ${NavLink}, ${LogoLink} {
    ${tw`text-gray-100 hover:border-gray-300 hover:text-gray-300`}
  }
  ${NavToggle}.closed {
    ${tw`text-gray-100 hover:text-primary-500`}
  }
`;
const Container = styled.div`
  ${tw`relative -mx-8 -mt-8 bg-center bg-cover`}
  background-image: url("https://bafybeic3oagnurlzkq23aqgmivfceibvll3pzdmr2da3gebzwovoiuwps4.ipfs.dweb.link/Screen%20Shot%202022-01-31%20at%2010.21.35%20PM.png");
`;

const OpacityOverlay = tw.div`z-10 absolute inset-0 bg-primary-500 opacity-25`;

const HeroContainer = tw.div`z-20 relative px-4 sm:px-8 max-w-screen-xl mx-auto`;
const TwoColumn = tw.div`pt-24 pb-32 px-4 flex justify-between items-center flex-col lg:flex-row`;
const LeftColumn = tw.div`flex flex-col items-center lg:block`;
const RightColumn = tw.div`w-full sm:w-5/6 lg:w-1/2 mt-16 lg:mt-0 lg:pl-8`;

const Heading = styled.h1`
  ${tw`text-3xl text-center lg:text-left sm:text-4xl lg:text-5xl xl:text-6xl font-black text-gray-100 leading-none`}
  span {
    ${tw`inline-block mt-2`}
  }
`;

const SlantedBackground = styled.span`
  ${tw`relative text-primary-500 px-4 -mx-4 py-2`}
  &::before {
    content: "";
    ${tw`absolute inset-0 bg-gray-100 transform -skew-x-12 -z-10`}
  }
`;



const PrimaryAction = tw.button`px-8 py-3 mt-10 text-sm sm:text-base sm:mt-16 sm:px-8 sm:py-4 bg-gray-100 text-primary-500 font-bold rounded shadow transition duration-300 hocus:bg-primary-500 hocus:text-gray-100 focus:shadow-outline`;

const StyledResponsiveVideoEmbed = styled(ResponsiveVideoEmbed)`
  padding-bottom: 56.25% !important;
  padding-top: 0px !important;
  ${tw`rounded`}
  iframe {
    ${tw`rounded bg-black shadow-xl`}
  }
`;


export const HeroSection = () => {
  const [isModalVisible, setIsModalVisible] = useState(false);
  const handleModal = () => {
    setIsModalVisible(true);
  }

  const handleOk = () => { //modal. should abs
    setIsModalVisible(false);
  };

  const handleCancel = () => { //modal. should abs
    setIsModalVisible(false);
  };

  const modalStyles = {
    display: isModalVisible ? "block" : 'none',
  }

  const navLinks = [
    <NavLinks key={1}>
      <NavLink href="https://ipfs.io/ipfs/QmR12W9NSUT8sRmAkhTAHmWnmLiZAHfKRqFCanbjec21Ei" target="_blank">
        Diamond Idea
      </NavLink>
      <NavLink href="https://ipfs.io/ipfs/QmR12W9NSUT8sRmAkhTAHmWnmLiZAHfKRqFCanbjec21Ei">
        Tools for Birds
      </NavLink>
      <NavLink href="https://docs.google.com/presentation/d/1FysFroMA5JVOjpp3dHZc33gwIGsLrgLiUEcyiEJBUjM/edit?usp=sharing">
        Duck Deck
      </NavLink>
    </NavLinks>,
    <NavLinks key={2}>

    </NavLinks>
  ];

  return (
    <Container>
      <OpacityOverlay />
      <HeroContainer>
        <StyledHeader links={navLinks} />
        <TwoColumn>
          <LeftColumn>
            <Heading>
              <span>Hackathon RPG</span>
              <span>Team Building</span>
              <br />
              <SlantedBackground>For Birds.</SlantedBackground>
            </Heading>
            <PrimaryAction onClick={handleModal}>Learn to Fly</PrimaryAction>
          </LeftColumn>
          <RightColumn>
            <iframe width="560" height="315" src="https://www.youtube.com/embed/1pgHzvYKdos" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
          </RightColumn>
        </TwoColumn>
      </HeroContainer>
    </Container>
  );
};
