import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'mocks.dart';

final cartoonSectionAuthorKey =
    Key('CartoonSection_Author_${mockPoliticalCartoon.id}');

const dailyCartoonTabKey = Key('TabSelector_DailyTab');
const allCartoonTabKey = Key('TabSelector_AllTab');
const changeThemeTabKey = Key('TabSelector_ChangeTheme');
const detailsPageBackButtonKey = Key('DetailsPage_BackButton');

const dailyCartoonInProgressKey =
    Key('DailyCartoonView_DailyCartoonInProgress');
const dailyCartoonLoadedKey = Key('DailyCartoonView_DailyCartoonLoaded');
const dailyCartoonFailedKey = Key('DailyCartoonView_DailyCartoonFailed');
const dailyCartoonMenuButtonKey = Key('DailyCartoonView_OpenDrawer');


const nextPageOnboardingButtonKey = Key('OnboardingPage_NextPage');
const setSeenOnboardingButtonKey = Key('OnboardingPage_SetSeenOnboarding');
const startCompleteOnboardingButtonKey = Key('OnboardingPage_StartButton');

const allCartoonsLoadingKey =
    Key('AllCartoonsPage_AllCartoonsLoading');
const allCartoonsLoadedKey = Key('AllCartoonsPage_AllCartoonsLoaded');
const allCartoonsFailedKey = Key('AllCartoonsPage_AllCartoonsFailed');
const allCartoonsFilterButtonKey = Key('AllCartoonsPage_FilterButton');
const allCartoonsMenuButtonKey = Key('AllCartoonsView_OpenDrawer');

const loggingInKey = Key('LoginPage_LoggingIn');
const unauthenticatedKey = Key('LoginPage_LoginError');
const signInAnonymouslyButtonKey = Key('LoginPage_SignInAnonymouslyButton');
const signInWithGoogleButtonKey = Key('LoginPage_SignInWithGoogleButton');

const resetFilterButtonKey = Key('ButtonRowHeader_ResetButton');
const applyFilterButtonKey = Key('ButtonRowHeader_ApplyFilterButton');

final sortByMode = SortByMode.latestPosted;
final tag = Tag.tag5;
final imageType = ImageType.cartoon;

final tagButtonKey = Key('Tag_Button_${tag.index}');
final sortByTileKey = Key('SortByMode_Button_${sortByMode.index}');
final imageTypeButtonKey = Key('ImageTypeCheckbox_${imageType.index}');
